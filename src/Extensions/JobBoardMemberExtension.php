<?php

namespace BiffBangPow\SilverstripeJobBoard\Extensions;

use BiffBangPow\SilverstripeJobBoard\Pages\JobPosting;
use SilverStripe\ORM\DataExtension;

class JobBoardMemberExtension extends DataExtension
{
    /**
     * @var array
     */
    private static $has_many = [
        'JobPostings' => JobPosting::class
    ];

    /**
     * @return string
     */
    public function getDetails()
    {
        return sprintf('%s %s - %s', $this->owner->FirstName, $this->owner->Surname, $this->owner->Email);
    }
}
