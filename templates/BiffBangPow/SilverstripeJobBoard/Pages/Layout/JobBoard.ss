<div class="job-board py-4">

    <div class="container">
        <div class="row">

            <div class="col-12">
                <h1 class="text-uppercase job-board__header-search">
                    <span class="font-weight-bold">Search results</span> <% if $CurrentTitleSearch %>$CurrentTitleSearch<% else %>for all jobs<% end_if %>
                </h1>
                <p class="job-board__header-results text-right"><strong>Jobs</strong> $Results.FirstItem - $Results.LastItem <strong>of</strong> $Results.TotalItems</p>
            </div>

            <div class="col-12 col-lg-3">

                <div class="panel job-board-filters mb-xs-5 mb-sm-5">

                    <form name="job-search" method="get">

                        <div class="job-board__job-search">

                            <div class="form-group">
                                <input type="text" class="form-control mb-2" id="job-search-title" name="t" value="$CurrentTitleSearch" placeholder="Search keywords" >
                            </div>

                            <button class="btn btn-primary btn-block mb-2" type="button" data-toggle="collapse" data-target="#sectorsCollapse" aria-expanded="false">
                                Sectors <i class="fal fa-chevron-down pl-2"></i>
                            </button>

                            <div class="collapse" id="sectorsCollapse">
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

                            <button class="btn btn-primary btn-block mb-2" type="button" data-toggle="collapse" data-target="#locationsCollapse" aria-expanded="false">
                                Locations <i class="fal fa-chevron-down pl-2"></i>
                            </button>

                            <div class="collapse" id="locationsCollapse">
                                <% loop $JobLocations %>
                                    <div class="form-check">
                                        <input
                                            class="form-check-input"
                                            type="radio"
                                            id="job-search-location"
                                            name="l"
                                            value="$ID"
                                            <% if $Top.IsSelectedLocation($ID) %>checked<% end_if %>
                                        />
                                        <label class="form-check-label" for="location$ID">$Title</label><br />
                                    </div>
                                <% end_loop %>
                            </div>

                        </div>

                        <button id="job-search-filter-btn" type="submit" class="mb-2 btn-block job-search-filter-btn btn btn-primary">
                            Filter <i class="fal fa-chevron-right pl-2"></i>
                        </button>

                        <a href="$Link" class="btn btn-outline-primary" id="job-search-reset">Reset</a>

                    </form>

                </div>

            </div>

            <div class="col-12 col-lg-9">
                <% loop $Results %>
                    <div class="job-board__posting mb-3">
                        <div class="row">
                            <div class="col-12">
                                <div class="job-summary pb-4">
                                    <h4><a href="$Link" class="text-dark"><div class="job-title-enhance" data-job-id="$ID">$Title</div></a></h4>
                                    <% if $DisplayLocation %>
                                        <p><i class="fa-fw fal fa-thumbtack"></i> $DisplayLocation</p>
                                    <% end_if %>
                                    <% if $Salary %>
                                        <p><i class="fa-fw fal fa-money-bill"></i> $Salary</p>
                                    <% end_if %>
                                    <p>$Excerpt</p>
                                    <a href="$Link" class="btn btn-primary">View <i class="fal fa-chevron-right ml-2"></i></a>
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
