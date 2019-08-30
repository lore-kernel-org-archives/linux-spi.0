From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
Date: Fri, 30 Aug 2019 10:06:21 +0530
Message-ID: <CAHO=5PG_rtONCLgOJCvUX7B=DENhow627xwXr3cQX_oOgmMmMw@mail.gmail.com>
References: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190829095907.GB4118@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829095907.GB4118@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 29, 2019 at 3:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 09:46:13AM +0530, Rayagonda Kokatanur wrote:
> > The spi-nor controller defaults to BSPI mode, hence switch back
> > to its default mode after MSPI operations (write or erase)
> > are completed.
> >
> > Changes from V1:
> >  - Address code review comment from Mark Brown.
>
> As covered in submitting-patches.rst inter-version changelogs should go
> after the --- so they don't end up in git.

Thank you, I fixed it and sent patch v3 for review.
