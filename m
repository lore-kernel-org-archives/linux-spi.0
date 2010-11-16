From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 04/12] spi: add ti-ssp spi master driver
Date: Tue, 16 Nov 2010 11:34:09 +0000
Message-ID: <20101116113409.GH3338@sirena.org.uk>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source@linux.davincidsp.com,
	dbrownell@users.sourceforge.net, sameo@linux.intel.com,
	khilman@deeprootsystems.com, linus.ml.walleij@gmail.com,
	rpurdie@rpsys.net, linux-arm-kernel@lists.infradead.org,
	Cyril Chemparathy <cyril@ti.com>, spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, lrg@slimlogic.co.uk
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
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

On Tue, Nov 16, 2010 at 12:47:04AM -0700, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely

> > Instead, it is now incumbent on the board support code to ensure that
> > any device that depends on another device (including i2c or spi
> > regulators) will defer registration until the prerequisite devices are
> > bound to drivers.

You did also say you were going to write helpers to make this easier - I
do fear that we're going to end up with far too much boiler plate code
in machine drivers if we have to open code this.  I guess device tree is
going to need the helpers anyway :)

> > I don't *think* this change will affect anything in this particular
> > patch series, but if it does then let me know and I'll help you work out
> > how to fix it using a bus notifier.

> Oh, wait, spoke too soon.  You do add a regulator in this series, so
> this change will require a fixup.  The solution is to register an
> bus_notifier to the spi bus type before you start registering devices.

> It also requires deferring the musb_hdrc.1 and tps6116x registrations
> until the bus_notifier callback gets called with an indication that
> the regulator is bound.  It will look something like this:

Did you come up with a way of handling situations like cpufreq where we
have no device to wait for?
