From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 01/14] spi: qup: Enable chip select support
Date: Thu, 20 Jul 2017 11:00:29 +0530
Message-ID: <20170720053029.GA25583@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
 <1498556731-13087-2-git-send-email-varada@codeaurora.org>
 <20170717160151.teozg2ni4mqxotbd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sham Muthayyan <smuthayy-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170717160151.teozg2ni4mqxotbd-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Brown,

On Mon, Jul 17, 2017 at 05:01:51PM +0100, Mark Brown wrote:
> On Tue, Jun 27, 2017 at 03:15:18PM +0530, Varadarajan Narayanan wrote:
>
> > the chip select support was removed earlier in commit
> > 4a8573abe965115bc5b064401fd669b74e985258. Since the chip
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Sorry. The commit being referred to is (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a8573abe965115bc5b064401fd669b74e985258)

	commit 4a8573abe965115bc5b064401fd669b74e985258
	Author: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
	Date:   Thu Jun 12 14:34:10 2014 -0500

	spi: qup: Remove chip select function

	This patch removes the chip select function.  Chip select should instead be
	supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
	core assert/deassert the chip select as it sees fit.

	The chip select control inside the controller is buggy.  It is supposed to
	automatically assert the chip select based on the activity in the controller,
	but it is buggy and doesn't work at all.  So instead we elect to use GPIOs.

	Signed-off-by: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
	Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Will update the commit log and repost the patches.

Thanks
Varada

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
