<?php

namespace BiffBangPow\SilverstripeJobBoard\DataObjects;

use BiffBangPow\SilverstripeJobBoard\Pages\JobBoard;
use BiffBangPow\SilverstripeJobBoard\Pages\JobPosting;
use SilverStripe\Forms\FieldList;
use SilverStripe\ORM\DataList;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\FieldType\DBVarchar;

/**
 * @method JobSector[]|DataList JobSectors
 */
class JobSector extends DataObject
{
    /**
     * @var string
     */
    private static $table_name = 'JobSector';

    /**
     * @var array
     */
    private static $db = [
        'Title' => DBVarchar::class,
    ];

    /**
     * @var array
     */
    private static $has_one = [
        'JobBoard' => JobBoard::class,
    ];

    /**
     * @var array
     */
    private static $belongs_many_many = [
        'JobPostings' => JobPosting::class,
    ];

    /**
     * @var array
     */
    private static $summary_fields = [
        'Title'             => 'Title',
        'JobPostings.Count' => 'Jobs',
    ];

    /**
     * @var string
     */
    private static $default_sort = 'Title';

    /**
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        $fields->removeByName('JobPostings');

        return $fields;
    }

    /**
     * @return mixed
     */
    public function getLink()
    {
        return $this->JobBoard()->Link() . '?s%5B%5D=' . $this->ID;
    }

    /**
     * @param null $member
     * @return bool|int
     */
    public function canView($member = null)
    {
        return true;
    }

    /**
     * @param null $member
     * @return bool|int
     */
    public function canEdit($member = null)
    {
        return false;
    }

    /**
     * @param null $member
     * @return bool|int
     */
    public function canDelete($member = null)
    {
        return false;
    }

    /**
     * @param null $member
     * @param array $context
     * @return bool|int
     */
    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    /**
     * @param null $member
     * @return bool|int
     */
    public function canArchive($member = null)
    {
        return false;
    }

    /**
     * @param null $member
     * @return bool
     */
    public function canRestoreToDraft($member = null)
    {
        return false;
    }
}
