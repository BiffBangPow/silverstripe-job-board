<div class="job-posting py-4">
    <div class="container">

        <div class="row">
            <div class="col-12 col-lg-4 order-2 order-lg-1">
                <div class="panel job-posting__facts">

                    <div class="modal fade text-left" id="apply-modal" tabindex="-1" role="dialog">
                        <div class="modal-dialog modal-lg modal-dialog-centered text-dark" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Apply for $Title</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    $ApplyForm
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <% if $Owner.BlogProfileImage %>
                            <img class="card-img-top" src="$Owner.BlogProfileImage.FillMax(600, 600).Link" alt="Consultant image">
                        <% end_if %>
                        <div class="card-body">
                            <h5 class="card-title">$Owner.FirstName $Owner.Surname</h5>
                            <% if $Owner.Position %>
                                <p class="card-text mb-0">$Owner.Position</p>
                            <% end_if %>
                            <% if $Owner.PhoneNumber %>
                                <p class="card-text mb-0">$Owner.PhoneNumber</p>
                            <% end_if %>
                            <% if $Owner.Email %>
                                <p class="card-text mb-0">$Owner.Email</p>
                            <% end_if %>
                        </div>
                    </div>

                    <table class="table table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="row" colspan="2">Job details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if $Title %>
                                <tr>
                                    <th scope="row">Title</th>
                                    <td>$Title</td>
                                </tr>
                            <% end_if %>
                            <% if $Reference %>
                                <tr>
                                    <th scope="row">Reference</th>
                                    <td>$Reference</td>
                                </tr>
                            <% end_if %>
                            <% if $DisplayLocation %>
                                <tr>
                                    <th scope="row">Location</th>
                                    <td>$DisplayLocation</td>
                                </tr>
                            <% else_if $ReadableLocations %>
                                <tr>
                                    <th scope="row">Location</th>
                                    <td>$ReadableLocations</td>
                                </tr>
                            <% end_if %>
                            <% if $ReadableSectors %>
                                <tr>
                                    <th scope="row">Sector</th>
                                    <td>$ReadableSectors</td>
                                </tr>
                            <% end_if %>
                            <% if $ReadableTypes %>
                                <tr>
                                    <th scope="row">Type</th>
                                    <td>$ReadableTypes</td>
                                </tr>
                            <% end_if %>
                            <% if $Salary %>
                                <tr>
                                    <th scope="row">Salary</th>
                                    <td>$Salary</td>
                                </tr>
                            <% end_if %>
                            <% if $JobSkills %>
                                <tr>
                                    <th scope="row">Skills</th>
                                    <td>$JobSkills</td>
                                </tr>
                            <% end_if %>
                            <% if $JobStartDate %>
                                <tr>
                                    <th scope="row">Start Date</th>
                                    <td>$JobStartDate</td>
                                </tr>
                            <% end_if %>
                            <% if $JobDuration %>
                                <tr>
                                    <th scope="row">Duration</th>
                                    <td>$JobDuration</td>
                                </tr>
                            <% end_if %>
                            <% if $Posted %>
                                <tr>
                                    <th scope="row">Posted</th>
                                    <td>$Posted</td>
                                </tr>
                            <% end_if %>
                            <% if $Closes %>
                                <tr>
                                    <th scope="row">Closes</th>
                                    <td>$Closes</td>
                                </tr>
                            <% end_if %>
                        </tbody>
                    </table>

                    <div class="d-flex py-3">
                        <button
                            type="button"
                            class="btn btn-primary btn-block mb-2"
                            data-toggle="modal"
                            data-target="#apply-modal"
                        >Apply now <i class="fal fa-chevron-right ml-2"></i></button>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-8 order-1 order-lg-2">
                <div class="job-posting__detail m-auto pt-4 pt-lg-0 pb-lg-5">
                    <h1 class="job-posting__detail-header d-flex mb-3">$Title</h1>
                    <% if $ReadableSectors %>
                        <h4 class="job-posting__detail-header pb-3 d-flex">$ReadableSectors</h4>
                    <% end_if %>
                    <% if $JobDescription %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Job description</p>
                            <p class="job-posting-result">$JobDescription</p>
                        </div>
                    <% end_if %>
                    <% if $Skills %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Skills</p>
                            <p class="job-posting-result">$Skills</p>
                        </div>
                    <% end_if %>
                    <% if $Responsibilities %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Responsibilities</p>
                            <p class="job-posting-result">$Responsibilities</p>
                        </div>
                    <% end_if %>
                    <% if $Qualifications %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Qualifications</p>
                            <p class="job-posting-result">$Qualifications</p>
                        </div>
                    <% end_if %>
                    <% if $EducationRequirements %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Education Requirements</p>
                            <p class="job-posting-result">$EducationRequirements</p>
                        </div>
                    <% end_if %>
                    <% if $ExperienceRequirements %>
                        <div class="job-posting-detail-wrapper block-copy">
                            <p class="job-posting-detail-title">Experience Requirements</p>
                            <p class="job-posting-result">$ExperienceRequirements</p>
                        </div>
                    <% end_if %>
                </div>
            </div>
        </div>

    </div>

    <script type='application/ld+json'>
        {
            "@context": "http://schema.org",
            "@type": "JobPosting",
            "jobBenefits": "",
            "datePosted": "$Created",
            "description": "$JobDescription",
            "disambiguatingDescription": "$Summary",
            "image": "$SiteConfig.HeaderLogo.AbsoluteLink",
            "educationRequirements": "",
            "employmentType": "Permanent",
            "hiringOrganization" : {
                "@type" : "Organization",
                "name" : "$SiteConfig.Title",
                "sameAs" : "$AbsoluteLink",
                "logo" : "$SiteConfig.HeaderLogo.AbsoluteLink",
                "url": "$AbsoluteLink"
            },
            "experienceRequirements": "",
            "incentiveCompensation": "",
            "occupationalCategory": "$Function.Title",
            "jobLocation": {
                "@type": "Place",
                "address": {
                    "@type": "PostalAddress",
                    "addressLocality": "$JobLocation.Title",
                    "addressRegion": "$JobLocation.Title",
                    "postalCode": "0",
                    "streetAddress": "$JobLocation.Title"
                }
            },
            "baseSalary": {
                "@type": "MonetaryAmount",
                "currency": "USD",
                "value": {
                    "@type": "QuantitativeValue",
                    "minValue": "0",
                    "maxValue": "0",
                    "value": "0",
                    "unitText": "YEAR"
                }
            },
            "salaryCurrency": "GBP",
            "skills": "",
            "specialCommitments": "",
            "title": "$Title",
            "validThrough": "$ClosingDate",
            "workHours": ""
        }
    </script>
</div>