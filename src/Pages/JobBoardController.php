<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use PageController;
use SilverStripe\ORM\PaginatedList;

/**
 * @method JobBoard data
 */
class JobBoardController extends PageController
{

    const ITEMS_PER_PAGE = 10;

    /**
     * @return PaginatedList
     * @throws Exception
     */
    public function getResults()
    {
        $dataList = JobPosting::get();

        $filters = [
            'Parent.ID'                      => $this->data()->ID,
            'ClosingDate:GreaterThanOrEqual' => date('Y-m-d'),
        ];
        $filterAny = [];

        $textSearch = $this->getRequest()->getVar('t');
        if (!is_null($textSearch)) {
            $filterAny['Title:PartialMatch'] = $textSearch;
            $filterAny['Summary:PartialMatch'] = $textSearch;
            $filterAny['JobDescription:PartialMatch'] = $textSearch;
        }

        $sectorIDs = $this->getRequest()->getVar('s');
        if (!is_null($sectorIDs)) {
            $filters['JobSectors.ID'] = $sectorIDs;
        }

        $locationID = $this->getRequest()->getVar('l');
        if (!is_null($locationID) && $locationID !== '') {
            $filters['JobLocation.ID'] = $locationID;
        }

        $dataList = $dataList->filter($filters);
        $dataList = $dataList->filterAny($filterAny);

        $paginatedList = new PaginatedList($dataList, $this->getRequest());
        $paginatedList->setPageLength(self::ITEMS_PER_PAGE);

        return $paginatedList;
    }

    /**
     * @param int $locationID
     * @return bool
     */
    public function IsSelectedLocation(int $locationID)
    {
        $locationID = (int)$locationID;
        $actualLocationID = (int)$this->getRequest()->getVar('l');
        return ($actualLocationID === $locationID);
    }

    /**
     * @return bool
     */
    public function IsNoLocationSelected()
    {
        return ($this->getRequest()->getVar('l') === null || $this->getRequest()->getVar('l') === '');
    }

    /**
     * @param int $typeID
     * @return bool
     */
    public function IsSelectedType($typeID)
    {
        $typeID = (int)$typeID;
        $actualTypeID = (int)$this->getRequest()->getVar('ty');
        return ($actualTypeID === $typeID);
    }

    /**
     * @return bool
     */
    public function IsNoTypeSelected()
    {
        return ($this->getRequest()->getVar('ty') === null || $this->getRequest()->getVar('ty') === '');
    }

    /**
     * @param int $hoursID
     * @return bool
     */
    public function IsSelectedHours($hoursID)
    {
        $hoursID = (int)$hoursID;
        $actualHoursID = (int)$this->getRequest()->getVar('h');
        return ($actualHoursID === $hoursID);
    }

    /**
     * @return bool
     */
    public function IsNoHoursSelected()
    {
        return ($this->getRequest()->getVar('h') === null || $this->getRequest()->getVar('h') === '');
    }

    /**
     * @return bool
     */
    public function IsSelectedSectors()
    {
        $sectorIDs = $this->getRequest()->getVar('s');
        return (!is_null($sectorIDs));
    }

    /**
     * @param int $sectorID
     * @return bool
     */
    public function IsSelectedSector($sectorID)
    {
        $sectorID = (int)$sectorID;
        $sectorIDs = $this->getRequest()->getVar('s');
        if (!is_null($sectorIDs)) {
            return in_array($sectorID, $sectorIDs);
        }
        return false;
    }

    /**
     * @return mixed
     */
    public function getCurrentTitleSearch()
    {
        return $this->getRequest()->getVar('t');
    }
}
