<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use Page;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobLocation;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobSector;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobCountry;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobDivision;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobFunction;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Lumberjack\Model\Lumberjack;

class JobBoard extends Page
{
    /**
     * @var array
     */
    private static $has_many = [
        'JobSectors'        => JobSector::class,
        'JobLocations'        => JobLocation::class,
    ];

    /**
     * @var array
     */
    private static $owns = [
        'JobSectors',
        'JobLocations'
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
