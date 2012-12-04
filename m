From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Date: Tue, 4 Dec 2012 14:44:57 +0000
Message-ID: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Miller <davem@davemloft.net>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	spi-devel-general@lists.sourceforge.net,
	Linux I2C <linux-i2c@vger.kernel.org>, software@gaisler.com
To: Andreas Larsson <andreas@gaisler.com>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
> This series removes the dependency on !SPARC for OF_I2C and removes the
> depencency of !defined(CONFIG_SPARC) for the function
> of_register_spi_devices. I find no reason for these to be unavailable
> for sparc.
>
> I am not sure if these should go through the sparc tree or the
> corresponding subsystem trees.

They should go through the subsystem trees.

What build testing have you done on these patches?

g.
