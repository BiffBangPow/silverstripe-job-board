<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use Page;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobFunction;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobLocation;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobSector;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataList;
use SilverStripe\ORM\FieldType\DBBoolean;
use SilverStripe\ORM\FieldType\DBDate;
use SilverStripe\ORM\FieldType\DBHTMLText;
use SilverStripe\ORM\FieldType\DBInt;
use SilverStripe\ORM\FieldType\DBText;
use SilverStripe\ORM\FieldType\DBVarchar;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;

/**
 * @method JobSector[]|DataList JobSectors
 * @method JobLocation JobLocation
 * @method Member Owner
 * @method JobBoard getParent
 * @property int OwnerID
 * @property string ClosingDate
 */
class JobPosting extends Page
{

    const EXCERPT_LENGTH = 280;

    private static $show_in_sitetree = false;

    private static $allowed_children = [];

    private static $db = [
        'LMReference'            => DBInt::class,
        'Summary'                => DBText::class,
        'DisplayLocation'        => DBVarchar::class,
        'JobDescription'         => DBHTMLText::class,
        'Salary'                 => DBVarchar::class,
        'ClosingDate'            => DBDate::class,
        'JobAlertsSent'          => DBBoolean::class
    ];

    private static $many_many = [
        "JobSectors" => JobSector::class,
    ];

    private static $has_one = [
        "JobLocation" => JobLocation::class,
        "JobFunction" => JobFunction::class,
        "Owner"       => Member::class,
    ];

    private static $summary_fields = [
        'Title'        => 'Title',
        'Owner.Email'  => 'Owner',
        'Parent.Title' => 'Job Board',
        'ClosingDate'  => 'Closing Date',
        'Created'      => 'Created',
    ];

    private static $default_sort = 'Created DESC';

    /**
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        $fields->removeByName('ElementalArea');
        $fields->removeByName('MenuTitle');
        $fields->removeByName('Metadata');
        $fields->removeByName('Menus');
        $fields->removeByName('Title');
        $fields->removeByName('SEOTitle');

        $fields->addFieldsToTab('Root.Main',
            [
                TextField::create('Title', 'Job Title'),
                DropdownField::create('ParentID', 'Job Board', JobBoard::get()->map())
            ],
            'Content'
        );

        $hasParent = ($this->getParent() !== null && $this->getParent()->ID !== 0);

        if ($hasParent) {
            $fields->addFieldsToTab('Root.Main',
                [
                    TextField::create('Salary', 'Salary'),
                    DateField::create('ClosingDate', 'Closing Date'),
                    TextareaField::create('Summary', 'Summary'),
                    HTMLEditorField::create('JobDescription', 'Job Description'),
                    CheckboxSetField::create(
                        'JobSectors',
                        'Sectors',
                        $this->getParent()->JobSectors()->map('ID', 'Title')->toArray(),
                        $this->JobSectors()
                    ),
                    DropdownField::create(
                        'JobLocationID',
                        'Location',
                        $this->getParent()->JobLocations()
                            ->map('ID', 'Title')
                    )->setEmptyString('Select a location'),
                    DropdownField::create(
                        'JobFunctionID',
                        'Function',
                        $this->getParent()->JobFunctions()
                            ->map('ID', 'Title')
                    )->setEmptyString('Select a location')
                ]
            );
        }

        if ($this->OwnerID !== 0 && $this->OwnerID !== null) {

            $currentUser = Security::getCurrentUser();

            $ownerField = DropdownField::create(
                'OwnerID',
                'Owner',
                Member::get()->map('ID', 'getDetails')
            );

            if (!$currentUser->inGroup('Administrators')) {
                $ownerField->setDisabled(true);
            }

            $fields->addFieldToTab(
                'Root.Main',
                $ownerField,
                'Link'
            );
        }

        return $fields;
    }

    /**
     * @return string
     */
    public function Closes()
    {

        $seconds = strtotime($this->ClosingDate) - time();
        $days = $seconds / 60 / 60 / 24;
        $days += 1;
        if ($days < 0) {
            return "closed";
        }
        if ($days < 1) {
            return "today";
        }
        if ($days < 2) {
            return "tomorrow";
        }
        return floor($days) . " days";
    }

    /**
     * @return string
     */
    public function Posted()
    {

        $seconds = time() - strtotime($this->Created);
        $days = $seconds / 60 / 60 / 24;
        $days += 1;
        if ($days < 0) {
            return "now";
        }
        if ($days < 1) {
            return "today";
        }
        if ($days < 2) {
            return "yesterday";
        }
        return floor($days) . " days ago";
    }

    /**
     * @return string
     */
    public function getReadableSectors()
    {
        /** @var DataList $sectors */
        $sectors = $this->JobSectors();
        return implode(', ', $sectors->map()->toArray());
    }

    public function getExcerpt(): string
    {
        if ($this->Summary) {
            $excerpt = $this->Summary;
        } else {
            $excerpt = $this->JobDescription;
        }
        $excerpt = html_entity_decode(strip_tags($excerpt),ENT_QUOTES);
        $excerpt = preg_replace("/\r|\n/", " ", $excerpt);
        $excerpt = preg_replace("/ +/", " ", $excerpt);
        // Minus 3 is to account for the ellipsis
        $excerpt = strlen($excerpt) > self::EXCERPT_LENGTH ? substr($excerpt, 0, (self::EXCERPT_LENGTH - 3)) . "..." : $excerpt;
        $excerpt = htmlentities($excerpt);
        return $excerpt;
    }

    /**
     * {@inheritdoc}
     */
    protected function onBeforeWrite()
    {
        parent::onBeforeWrite();

        if ($this->OwnerID == 0) {
            $this->OwnerID = Security::getCurrentUser()->ID;
        }
    }

    /**
     * @return void
     */
    public function onAfterDelete()
    {
        parent::onAfterDelete();
        $this->doUnpublish();
    }
}
