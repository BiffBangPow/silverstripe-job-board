<?php

use SilverStripe\Admin\ModelAdmin;

class JobsAdmin extends ModelAdmin
{
    const JOBS_ADMIN_PERMISSION = 'CMS_ACCESS_JobsAdmin';

    private static $managed_models = [
        JobPosting::class,
        JobDivision::class,
        JobSector::class,
        JobCountry::class,
        JobLocation::class,
        JobFunction::class
    ];

    private static $url_segment = 'jobs';

    private static $menu_title = 'Jobs';

}
