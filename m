From: Martin Sperl <martin@sperl.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Tue, 28 Apr 2015 07:32:21 +0200
Message-ID: <55B19D93-B930-4363-9D44-0E97B4B836BF@sperl.org>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org> <20150427195550.GE22845@sirena.org.uk> <20150428012150.GA12713@deathray>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150428012150.GA12713@deathray>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On 28.04.2015, at 03:21, Michael Welling <mwelling@ieee.org> wrote:
> If I were to attempt to convert the driver to use the core chipselect support,
> how would I go about doing it?
> 
> Is there another driver that I can use for reference?
You may look into this patch: e34ff011c70e5f4ef219141711142d5111ae6ebb
for the spi-bcm2835 driver, which did the conversion to the new transfer_one
interface (and framework based GPIO chipselects).

For most parts all you have to do is take the contents of the loop over all the
spi_transfers inside your master->transfer_one_message method and create a new
method with it and assign it to master->transfer_one.
