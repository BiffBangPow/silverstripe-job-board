<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use Page;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobLocation;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobSector;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobType;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataList;
use SilverStripe\ORM\FieldType\DBDate;
use SilverStripe\ORM\FieldType\DBHTMLText;
use SilverStripe\ORM\FieldType\DBText;
use SilverStripe\ORM\FieldType\DBVarchar;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;

/**
 * @method JobSector[]|DataList JobSectors
 * @method JobLocation[]|DataList JobLocations
 * @method JobType[]|DataList JobTypes
 * @method Member Owner
 * @method JobBoard getParent
 * @property int OwnerID
 * @property string ClosingDate
 */
class JobPosting extends Page
{
    /**
     * @var string
     */
    private static $table_name = 'JobPosting';

    const EXCERPT_LENGTH = 280;

    private static $show_in_sitetree = false;

    private static $allowed_children = [];

    private static $db = [
        'Reference'       => DBVarchar::class,
        'Summary'         => DBText::class,
        'DisplayLocation' => DBVarchar::class,
        'JobDescription'  => DBHTMLText::class,
        'Salary'          => DBVarchar::class,
        'ClosingDate'     => DBDate::class,
        'JobDuration'     => DBVarchar::class,
        'JobStartDate'    => DBVarchar::class,
        'JobSkills'       => DBVarchar::class,
    ];

    private static $many_many = [
        "JobSectors"   => JobSector::class,
        "JobLocations" => JobLocation::class,
        "JobTypes"     => JobType::class,
    ];

    private static $has_one = [
        "Owner" => Member::class,
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

        $fields->removeByName('Content');

        $fields->addFieldsToTab('Root.Main',
            [
                TextField::create('Title', 'Job Title'),
                DropdownField::create('ParentID', 'Job Board', JobBoard::get()->map()),
            ],
            'Content'
        );

        $hasParent = ($this->getParent() !== null && $this->getParent()->ID !== 0);

        if ($hasParent) {
            $fields->addFieldsToTab('Root.Main',
                [
                    TextField::create('Reference', 'Reference'),
                    TextField::create('JobDuration', 'Job Duration'),
                    TextField::create('JobStartDate', 'Job Start Date'),
                    TextField::create('JobSkills', 'Job Skills'),
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
                    CheckboxSetField::create(
                        'JobLocations',
                        'Location',
                        $this->getParent()->JobLocations()->map('ID', 'Title')->toArray(),
                        $this->JobLocations()
                    ),
                    CheckboxSetField::create(
                        'JobTypes',
                        'Types',
                        $this->getParent()->JobTypes()->map('ID', 'Title')->toArray(),
                        $this->JobTypes()
                    ),
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
            return "Closed";
        }
        if ($days < 1) {
            return "Today";
        }
        if ($days < 2) {
            return "Tomorrow";
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
            return "Now";
        }
        if ($days < 1) {
            return "Today";
        }
        if ($days < 2) {
            return "Yesterday";
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

    /**
     * @return string
     */
    public function getReadableLocations()
    {
        /** @var DataList $locations */
        $locations = $this->JobLocations();
        return implode(', ', $locations->map()->toArray());
    }

    /**
     * @return string
     */
    public function getReadableTypes()
    {
        /** @var DataList $jobTypes */
        $jobTypes = $this->JobTypes();
        return implode(', ', $jobTypes->map()->toArray());
    }

    public function getExcerpt(): string
    {
        if ($this->Summary) {
            $excerpt = $this->Summary;
        } else {
            $excerpt = $this->JobDescription;
        }
        $excerpt = html_entity_decode(strip_tags($excerpt), ENT_QUOTES);
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
