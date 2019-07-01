<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use Page;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobLocation;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobSector;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobType;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Lumberjack\Model\Lumberjack;

class JobBoard extends Page
{
    /**
     * @var string
     */
    private static $table_name = 'JobBoard';

    /**
     * @var array
     */
    private static $has_many = [
        'JobSectors'   => JobSector::class,
        'JobLocations' => JobLocation::class,
        'JobTypes'     => JobType::class,
    ];

    /**
     * @var array
     */
    private static $owns = [
        'JobSectors',
        'JobLocations',
        'JobTypes',
    ];

    private static $extensions = [
        Lumberjack::class,
    ];

    private static $allowed_children = [
        JobPosting::class,
    ];

    /**
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        $fields->removeByName('Content');
        $fields->removeByName('ElementalArea');

        $fields->addFieldToTab('Root.Sectors', GridField::create(
            'JobSectors',
            'Sectors',
            $this->JobSectors(),
            GridFieldConfig_RecordEditor::create()
        ));

        $fields->addFieldToTab('Root.Locations', GridField::create(
            'JobLocations',
            'Locations',
            $this->JobLocations(),
            GridFieldConfig_RecordEditor::create()
        ));

        $fields->addFieldToTab('Root.Types', GridField::create(
            'JobTypes',
            'Types',
            $this->JobTypes(),
            GridFieldConfig_RecordEditor::create()
        ));

        return $fields;
    }

    /**
     * @return string
     */
    public function getLumberjackTitle()
    {
        return "Jobs";
    }
}
