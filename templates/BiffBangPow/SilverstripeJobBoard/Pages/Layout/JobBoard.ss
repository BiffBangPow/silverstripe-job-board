<div class="job-board">

    <div class="container">
        <div class="row">

            <div class="col-12 job-board__header d-flex py-4 py-xl-6">
                <h1 class="text-uppercase job-board__header-search pr-4"><span class="font-weight-bold">Search results</span> <% if $CurrentTitleSearch %>$CurrentTitleSearch<% else %>for all jobs<% end_if %></h1>
                <span class="job-board__header-results"><strong>Jobs</strong> $Results.FirstItem - $Results.LastItem <strong>of</strong> $Results.TotalItems</span>
            </div>

            <div class="col-12 col-lg-3">

                <div class="panel job-board-filters mb-xs-5 mb-sm-5">

                    <form name="job-search" method="get">

                        <div class="job-board-filters__header d-flex">

                            <div class="job-board-filters__header-title p-2 p-xl-3">
                                <i class="fa fa-sliders-h"></i> FILTER
                            </div>

                            <div class="d-flex px-2 px-xl-3">
                                <a href="$Link" class="btn btn-outline-primary px-3 py-1 my-auto" id="job-search-reset">reset</a>
                            </div>

                        </div>


                        <div class="job-board__job-search">

                            <div class="py-2 px-2 px-lg-3 job-search-title-wrapper">
                                <input id="job-search-title" class="job-search-title my-2 my-xl-3" type="text" name="t" value="$CurrentTitleSearch" placeholder="search keywords" />
                                <i class="fal fa-search px-4"></i>
                            </div>

                            <button class="job-board-collapse-btn py-3 px-2 px-lg-3" type="button" data-toggle="collapse" data-target="#job-search-sectors-collapse" aria-expanded="false" aria-controls="job-search-sectors-collapse">
                                Sectors <i class="fas fa-chevron-down"></i>
                            </button>
                            
                            <div class="collapse <% if $IsSelectedSectors %>show<% end_if %>" id="job-search-sectors-collapse">
                                <div class="py-3 px-2 px-lg-3">
                                    <% loop $JobDivisions %>
                                        <div class="mb-3">
                                            <h5 class="mb-2">$Title</h5>
                                            <% loop $JobSectors %>
                                                <div class="form-check">
                                                    <input
                                                            type="checkbox"
                                                            id="sector$ID"
                                                            name="s[]"
                                                            value="$ID"
                                                            class="form-check-input"
                                                            <% if $Top.IsSelectedSector($ID) %>checked<% end_if %>
                                                    />
                                                    <label class="form-check-label" for="sector$ID">$Title</label>
                                                </div>
                                            <% end_loop %>
                                        </div>
                                    <% end_loop %>
                                </div>
                            </div>

                            <button class="job-board-collapse-btn py-3 px-2 px-lg-3" type="button" data-toggle="collapse" data-target="#job-search-functions-collapse" aria-expanded="false" aria-controls="job-search-sectors-collapse">
                                Function <i class="fas fa-chevron-down"></i>
                            </button>

                            <div class="collapse <% if $IsSelectedFunctions %>show<% end_if %>" id="job-search-functions-collapse">
                                <div class="py-3 px-2 px-lg-3">
                                    <% loop $JobFunctions %>
                                        <div class="form-check">
                                            <input
                                                type="checkbox"
                                                id="function$ID"
                                                name="f[]"
                                                value="$ID"
                                                class="form-check-input"
                                                <% if $Top.IsSelectedFunction($ID) %>checked<% end_if %>
                                            />
                                            <label class="form-check-label" for="function$ID">$Title</label>
                                        </div>
                                    <% end_loop %>
                                </div>
                            </div>

                            <button class="job-board-collapse-btn py-3 px-2 px-lg-3" type="button" data-toggle="collapse" data-target="#job-search-locations-collapse" aria-expanded="false" aria-controls="job-search-locations-collapse">
                                Locations <i class="fas fa-chevron-down"></i>
                            </button>

                            <div class="collapse <% if not $IsNoLocationSelected %>show<% end_if %>" id="job-search-locations-collapse">
                                <div class="py-3 px-2 px-lg-3">
                                    <div class="form-check">
                                        <input
                                            class="form-check-input"
                                            type="radio"
                                            id="job-search-location"
                                            name="l"
                                            value=""
                                            <% if $IsNoLocationSelected %>checked<% end_if %> />

                                        <label class="form-check-label" for="location$ID">All</label><br />
                                        <% loop $JobCountries %>
                                            <% loop $JobLocations %>
                                                <input
                                                    class="form-check-input"
                                                    type="radio"
                                                    id="job-search-location"
                                                    name="l"
                                                    value="$ID"
                                                    <% if $Up.Up.IsSelectedLocation($ID) %>checked<% end_if %> />

                                                <label class="form-check-label" for="location$ID">$Title</label><br />
                                            <% end_loop %>
                                        <% end_loop %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex pt-3 px-2 px-lg-3 flex-column align-items-start">
                            <button id="job-search-filter-btn" type="submit" class="job-search-filter-btn btn btn-primary py-2 px-4 mb-3">
                                Filter <i class="fas fa-arrow-right ml-2"></i>
                            </button>
                        </div>
                    </form>

                    <div class="d-flex pb-3 px-2 px-lg-3">

                        <!-- Button trigger modal -->
                        <button type="button" class="job-search-filter-btn btn btn-primary py-2 px-4" data-toggle="modal" data-target="#JobAlertsForm">
                            Job Alerts <i class="fas fa-paper-plane ml-2"></i>
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="JobAlertsForm" tabindex="-1" role="dialog">
                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">Subscribe to Job Alerts</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        $JobAlertsForm
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="col-12 col-lg-9">
                <% loop $Results %>
                    <div class="job-board__posting mb-3">
                        <div class="row no-gutters">
                            <div class="col-lg-7">
                                <div class="job-board__posting-title d-flex px-4 px-lg-6 pt-4 pb-2 col-12">
                                    <a href="$Link" class="text-dark"><div class="job-title-enhance" data-job-id="$ID">$Title</div></a>
                                </div>
                                <div class="job-summary px-4 px-lg-6 pt-2 pb-4">
                                    <p>$Excerpt</p>
                                </div>
                            </div>
                            <div class="col-lg-5 d-flex flex-column">
                                <div class="details h-100 d-flex flex-column p-4">

                                    <p class="mb-2 detail"><i class="text-primary fal mr-1 fa-fw fa-thumbtack"></i> $DisplayLocation</p>
                                    <p class="mb-3 detail"><i class="text-primary fal mr-1 fa-fw fa-money-bill"></i> $Salary</p>
                                    <a href="$Link" class="font-weight-bold text-primary view-job-link">VIEW JOB <i class="far fa-chevron-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% end_loop %>
            </div>

        </div>

        <div class="col-12">
            <nav class="pagination-nav">

                <% if $Results.MoreThanOnePage %>
                    <ul class="pagination justify-content-center">
                        <% if $Results.NotFirstPage %>
                            <li class="page-item"><a class="page-link" href="$Results.PrevLink">&lt;</a></li>
                        <% else %>
                            <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                        <% end_if %>
                        <% loop $Results.PaginationSummary(4) %>
                            <% if $CurrentBool %>
                                <li class="page-item active"><a class="page-link" href="#">$PageNum</a></li>
                            <% else %>
                                <% if $Link %>
                                    <li class="page-item"><a class="page-link" href="$Link">$PageNum</a></li>
                                <% else %>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">...</a></li>
                                <% end_if %>
                            <% end_if %>
                        <% end_loop %>
                        <% if $Results.NotLastPage %>
                            <li class="page-item"><a class="page-link" href="$Results.NextLink">&gt;</a></li>
                        <% else %>
                            <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                        <% end_if %>
                    </ul>
                <% end_if %>
            </nav>
        </div>

    </div>

</div>

<% if $Content %>
    <div class="container">
        $Content
    </div>
<% end_if %>

$ElementalArea
$Form
$CommentsForm
