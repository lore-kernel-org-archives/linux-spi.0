From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
Date: Wed, 24 Nov 2010 16:39:05 +0100
Message-ID: <4CED3199.2040700@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>, eric.y.miao@gmail.com,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux@arm.linux.org.uk, Grant Likely <grant.likely@secretlab.ca>,
	sodaville@linutronix.de, linux-arm-kernel@lists.infradead.org,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	spi-devel-general@lists.sourceforge.net, tglx@linutronix.de,
	drwyrm@gmail.com
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101124141623.GH24970@rakim.wolfsonmicro.main>
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

Mark Brown wrote:
> On Wed, Nov 24, 2010 at 03:09:25PM +0100, Sebastian Andrzej Siewior wrote:
> 
>> I've been pointed out to this commit but I don't understand _why_.
>> The part I don't get is "so it can be used with cpufreq". Is it
>> refered to a driver or the subsystem as it?
> 
> We need the regulators for the CPU rails to start before the cpufreq
> driver starts so cpufreq can talk to them, and since the regulators may
> be SPI attached this means we also need the SPI controller to start
> before cpufreq.  cpufreq starts at vanilla init time.

After digging through the code I think I've found it. pxa_cpu_init()
registers a cpufreq client. cpufreq calls init and pxa then
regulator_get() to get the regulator and I guess this is the problem.
So I would suggest to defer pxa_cpu_init() via late_initcall().

The other way around will force you to hack the init code for various
drivers to make it work.

Sebastian
