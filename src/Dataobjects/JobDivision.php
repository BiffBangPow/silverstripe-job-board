<?php

use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\FieldType\DBVarchar;

class JobDivision extends DataObject
{
    /**
     * @var array
     */
    private static $db = [
        'Title' => DBVarchar::class,
    ];

    /**
     * @var array
     */
    private static $has_many = [
        'JobSectors' => JobSector::class
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
    private static $summary_fields = [
        'Title'                   => 'Title',
        'JobSectors.Count'        => 'Sectors',
    ];

    /**
     * @var string
     */
    private static $default_sort = 'Title';

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
