From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v7 00/12] tnetv107x ssp drivers
Date: Fri, 10 Dec 2010 16:19:48 -0800
Message-ID: <87r5dp6tzv.fsf@deeprootsystems.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source@linux.davincidsp.com,
	dbrownell@users.sourceforge.net, sameo@linux.intel.com,
	linus.ml.walleij@gmail.com, broonie@opensource.wolfsonmicro.com,
	grant.likely@secretlab.ca, rpurdie@rpsys.net, alan@lxorguk.ukuu.org.uk,
	spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	lrg@slimlogic.co.uk
To: Cyril Chemparathy <cyril@ti.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1291733522-3626-1-git-send-email-cyril@ti.com> (Cyril
	Chemparathy's message of "Tue, 7 Dec 2010 09:51:50 -0500")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Cyril Chemparathy <cyril@ti.com> writes:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).

OK, this series seems to be stabilizing.  The question now is how to
merge it.

I'm happy to merge it as a single series via the davinci tree as long as
I get some acks on the drivers.  For me to merge this, I'm missing some
acks for the following:

[PATCH v7 04/12] spi: add ti-ssp spi master driver
Grant Likely, although I thought he gave an ack earlier)

[PATCH v7 10/12] backlight: add support for tps6116x controller
Richard Purdie

[PATCH v7 08/12] gpio: add ti-ssp gpio driver
David Brownell?  (MAINTAINERS isn't clear here)

If I get acks soon, we can get this in for 2.6.38. 

Thanks,

Kevin
