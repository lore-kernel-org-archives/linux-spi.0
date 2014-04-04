From: Harini Katakam <harinikatakamlinux@gmail.com>
Subject: Re: [PATCH v2 1/2] SPI: Add driver for Cadence SPI controller
Date: Fri, 4 Apr 2014 09:19:23 +0530
Message-ID: <CAFcVEC+3QZ0CiBtPM7b-qGugraWpx4zSuQ-ct4Q=Ywbn4ick+w@mail.gmail.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
	<20140403214322.GC14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Punnaiah Choudary Kalluri
	<punnaiah.choudary.kalluri@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140403214322.GC14763@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark

On Fri, Apr 4, 2014 at 3:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 03, 2014 at 04:40:30PM +0530, Harini Katakam wrote:
>> Add driver for Cadence SPI controller. This is used in Xilinx Zynq.
>
> I just reviewed a driver for "Zynq Quad SPI controller" from Punnaiah
> Choudary Kalluri (CCed) which seems *very* similar to this one.  Are
> there opportunities for code sharing here (I'm not entirely sure the
> hardware blocks are different, though I didn't check in detail).
>

Thanks for the review.

QSPI is a Xilinx IP built on top of cadence SPI  with
considerable functional changes.
As explained in the QSPI patch, there are three configurations
QSPI supports :

- A single flash device connected with 1 CS and 4 IO lines
- Two flash devices connected over two separate sets of 4 IO lines
  and two CS lines which are driven together.
- Two flash devices connected with two separate CS line and one
  common set of 4 IO lines.

This first set of QSPI patches is only for the single flash configuration.
As the next two configurations follow, QSPI driver will differ from SPI
even more. That's why it might be better to have two separate drivers.
It will avoid a lot of "if spi/ if qspi" checks.

I will send an RFC with proposed changes for all QSPI configurations.

Also, I've replied to your comments on the QSPI driver.
(The QSPI driver already addresses the comments for SPI v1)
Except in two places where the comment was only applicable to QSPI driver,
the replies hold good for both SPI and QSPI drivers.
If you would like to continue the discussion on that thread, I'm ok with it.
FYI, I'll be sending the next versions for both drivers after further
discussion concludes.

Regards,
Harini
