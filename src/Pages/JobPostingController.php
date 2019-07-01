<?php

namespace BiffBangPow\SilverstripeJobBoard\Pages;

use PageController;
use SilverStripe\Assets\File;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\Control\Director;
use SilverStripe\Control\Email\Email;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\FileField;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\ValidationException;
use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Control\HTTPResponse;

/**
 * @method JobBoard data
 */
class JobPostingController extends PageController
{
    /**
     * @var array
     */
    private static $allowed_actions = [
        'ApplyForm',
    ];

    /**
     * @return Form
     */
    public function ApplyForm()
    {
        $siteTitle = SiteConfig::current_site_config()->Title;
        $linkHTML = 'By ticking this box you consent to ' . $siteTitle . ' contacting you with regards to your enquiry, and are agreeing to the privacy notice';

        $fields = FieldList::create([
            TextField::create('FullName')->addExtraClass('col-12'),
            EmailField::create('Email')->addExtraClass('col-md-6'),
            TextField::create('PhoneNumber', 'Phone Number')->addExtraClass('col-md-6'),
            TextareaField::create('CoverLetter')->setRows(7)->addExtraClass('col-12'),
            FileField::create('CV', 'CV')->setAllowedFileCategories('document', 'image')->setFolderName('CVSubmissions')->addExtraClass('col-12'),
            CheckboxField::create('ContactConsent', $linkHTML)->addExtraClass('col-12'),
        ]);

        $actions = FieldList::create(
            FormAction::create('sendApplyForm', 'Submit')->addExtraClass('btn-primary')
        );

        $form = Form::create(
            $this,
            __FUNCTION__,
            $fields,
            $actions,
            new RequiredFields([
                    'FullName',
                    'PhoneNumber',
                    'Email',
                    'CoverLetter',
                    'ContactConsent',
                ]
            ));

        return $form;
    }

    /**
     * @param $data
     * @param Form $form
     * @return HTTPResponse
     * @throws ValidationException
     */
    public function sendApplyForm($data, $form)
    {
        $config = SiteConfig::current_site_config();
        $from = $config->ContactFromEmail;
        $recipient = $this->Owner()->Email;

        $data = $form->getData();

        if ($data['ContactConsent'] === 1) {

            $data['ConsultantName'] = $this->Owner()->FirstName . ' ' . $this->Owner()->Surname;
            $data['JobTitle'] = $this->Title;
            $data['JobLink'] = Director::absoluteBaseURL() . $this->Link();

            $email = Email::create();
            $email->setHTMLTemplate('ApplyFormEmail');
            $email->setFrom($from);
            $email->setTo($recipient);
            $email->setSubject('Application for ' . $this->Title);

            if ($data['CV']['tmp_name'] !== '') {
                $cv = new File();
                $cv->setFromLocalFile($data['CV']['tmp_name'], $data['CV']['name']);
                $cv->write();
                $cv->updateFilesystem();
                $cv->publishSingle();
                $email->addAttachment(Director::baseFolder() . '/public' . $cv->getSourceURL());
            }

            $email->setData($data);
            $email->send();

            $candidateEmail = Email::create();
            $candidateEmail->setHTMLTemplate('ApplyFormCandidateEmail');
            $candidateEmail->setFrom($from);
            $candidateEmail->setTo($data['Email']);
            $candidateEmail->setSubject('Application for ' . $this->Title);

            if ($data['CV']['tmp_name'] !== '') {
                $candidateEmail->addAttachment(Director::baseFolder() . '/public' . $cv->getSourceURL());
            }

            $candidateEmail->setData($data);
            $candidateEmail->send();

            $this->flashMessage('Thank you for your application, we will be in touch soon', 'success');
        } else {
            $this->flashMessage('Your application has not been sent, we cannot process your data without your consent', 'danger');
        }

        return $this->redirect($this->Link());
    }
}
