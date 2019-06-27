<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use Page;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobCountry;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobDivision;
use BiffBangPow\SilverstripeJobBoard\DataObjects\JobFunction;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Lumberjack\Model\Lumberjack;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\DataList;
use SilverStripe\ORM\FieldType\DBBoolean;
use SilverStripe\ORM\FieldType\DBText;
use SilverStripe\ORM\SS_List;

/**
 * @method JobDivision[]|DataList JobDivisions
 * @method JobCountry[]|DataList JobCountries
 */
class JobBoard extends Page
{
    /**
     * @var array
     */
    private static $db = [
        'ShowInMainMenu'   => DBBoolean::class,
        'ShowInFooterMenu' => DBBoolean::class,
        'Keywords'         => DBText::class,
    ];

    private static $has_many = [
        'JobDivisions'        => JobDivision::class,
        'JobCountries'        => JobCountry::class,
        'JobFunctions'        => JobFunction::class,
    ];

    private static $owns = [
        'JobDivisions',
        'JobCountries',
        'JobFunctions'
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

        $fields->removeByName('ElementalArea');
        $fields->removeByName('MenuTitle');
        $fields->removeByName('Metadata');
        $fields->removeByName('Menus');
        $fields->removeByName('SEOTitle');

        $fields->addFieldToTab('Root.Divisions', GridField::create(
            'JobDivisions',
            'Divisions',
            $this->JobDivisions(),
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

    public function JobSectors(): SS_List
    {
        $jobSectors = [];

        foreach ($this->JobDivisions()->getIterator() as $division) {
            $jobSectors = array_merge($jobSectors, $division->JobSectors()->toArray());
        }

        return new ArrayList($jobSectors);
    }

    public function JobLocations(): SS_List
    {
        $jobLocations = [];

        foreach ($this->JobCountries()->getIterator() as $country) {
            $jobLocations = array_merge($jobLocations, $country->JobLocations()->toArray());
        }

        return new ArrayList($jobLocations);
    }

    /**
     * @return string
     */
    public function getLumberjackTitle()
    {
        return "Jobs";
    }
}
