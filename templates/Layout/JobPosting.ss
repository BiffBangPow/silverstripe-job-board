<div class="job-posting">
    <div class="container">

        <div class="row">
            <div class="col-12 col-lg-4 py-4 py-lg-6 order-2 order-lg-1">
                <div class="panel p-lg-4 job-posting__facts">
                    <div class="mb-2 d-flex row no-gutters job-posting__owner flex-column">
                        <% if $Owner.BlogProfileImage %>
                            <img class="owner-image mx-auto mb-4" src="$Owner.BlogProfileImage.FillMax(200, 200).Link" />
                        <% end_if %>
                        <a href="$Owner.BlogProfileLink" target="_blank"><h5 class="text-primary">$Owner.FirstName $Owner.Surname</h5></a>
                        <h6>$Owner.Position</h6>
                        <a class="phone d-block py-2 font-weight-bold" href="tel:$Owner.PhoneNumber">
                            <i class="pr-lg-3 pr-1 far fa-phone text-primary" aria-hidden="true"></i> $Owner.PhoneNumber
                        </a>
                        <a class="email d-block py-2 font-weight-bold" href="mailto:$Owner.Email">
                            <i class="pr-lg-3 pr-1 far fa-paper-plane text-primary" aria-hidden="true"></i> $Owner.Email
                        </a>

                        <hr class="border-gray-200" />

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
                    </div>
                    <div class="job-posting-panel mb-2">
                        <i class="fal mr-1 fa-fw fa-thumbtack text-primary"></i> $DisplayLocation
                    </div>
                    <% if $Salary %>
                        <div class="job-posting-panel mb-2">
                            <i class="fal mr-1 fa-fw fa-money-bill text-primary"></i> $Salary
                        </div>
                    <% end_if %>
                    <div class="job-posting-panel mb-2">
                        <i class="fal mr-1 fa-fw fa-calendar text-primary"></i> $Posted
                    </div>
                    <div class="job-posting-panel mb-2">
                        <i class="fal mr-1 fa-fw fa-alarm-clock text-primary"></i> $Closes
                    </div>
                    <div class="job-posting-panel mb-2">
                        <i class="fal mr-1 fa-fw fa-tags text-primary"></i> $ReadableSectors
                    </div>
                    <div class="job-posting-panel mb-2">
                        <i class="fal mr-1 fa-fw fa-user text-primary"></i> $JobFunction.Title
                    </div>
                    <div class="d-flex py-3">
                        <button
                            type="button"
                            class="btn btn-outline-primary px-4 py-2 mx-auto mb-3"
                            data-toggle="modal"
                            data-target="#apply-modal"
                        >Apply now <i class="far fa-chevron-right ml-2"></i></button>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-8 py-lg-6 order-1 order-lg-2">
                <div class="job-posting__detail m-auto pt-4 pt-lg-0 pb-lg-5">
                    <h1 class="job-posting__detail-header px-lg-6 pt-lg-3 d-flex mb-3">$Title</h1>
                    <h2 class="job-posting__detail-header pb-3 px-lg-6 d-flex">$ReadableSectors</h2>
                    <% if $JobDescription %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
                            <p class="job-posting-detail-title">Job description</p>
                            <p class="job-posting-result">$JobDescription</p>
                        </div>
                    <% end_if %>
                    <% if $Skills %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
                            <p class="job-posting-detail-title">Skills</p>
                            <p class="job-posting-result">$Skills</p>
                        </div>
                    <% end_if %>
                    <% if $Responsibilities %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
                            <p class="job-posting-detail-title">Responsibilities</p>
                            <p class="job-posting-result">$Responsibilities</p>
                        </div>
                    <% end_if %>
                    <% if $Qualifications %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
                            <p class="job-posting-detail-title">Qualifications</p>
                            <p class="job-posting-result">$Qualifications</p>
                        </div>
                    <% end_if %>
                    <% if $EducationRequirements %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
                            <p class="job-posting-detail-title">Education Requirements</p>
                            <p class="job-posting-result">$EducationRequirements</p>
                        </div>
                    <% end_if %>
                    <% if $ExperienceRequirements %>
                        <div class="job-posting-detail-wrapper px-lg-6 px-md-6 block-copy">
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
<% if $Content %>
    <div class="container">
        $Content
    </div>
<% end_if %>
$ElementalArea
$Form
$CommentsForm
