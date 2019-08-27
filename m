From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Date: Tue, 27 Aug 2019 09:01:42 -0400
Message-ID: <CAC=U0a2VsdrjypcLQCJTROmbF9ojuJ2rA4Og7XXeR48LAjrArA@mail.gmail.com>
References: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190806121612.GB4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806121612.GB4527@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-nor controller defaults to BSPI mode. So its being put to its
default mode.


Kamal

On Tue, Aug 6, 2019 at 8:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 06, 2019 at 03:44:34PM +0530, Rayagonda Kokatanur wrote:
> > Switch back to BSPI mode after MSPI operations (write and erase)
> > are completed. This change will keep qpsi in BSPI mode by default.
>
> Why?
