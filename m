From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
Date: Sun, 24 Feb 2019 12:03:33 +0100
Message-ID: <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
 <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
 <20190224103913.bjw7g6ievr75iawz@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224103913.bjw7g6ievr75iawz-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> On 24.02.2019, at 11:39, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> 
> On Sat, Feb 23, 2019 at 02:15:13PM +0100, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> On 23.02.2019, at 13:40, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
>>> On Sat, Feb 23, 2019 at 08:49:50AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>>> Support setting a delay between cs assert and deassert as
>>>> a multiple of spi clock length.
>>> 
>>> The ability to define a unit seems somewhat over-engineered to me.
>>> You're introducing lots of branching and integer divisions (both
>>> comparatively expensive operations) which are executed for every
>>> single transfer (i.e. in a hot path).  I'd recommend standardizing
>>> on a single unit.  If 1 usec is too coarse-grained for your use case,
>>> convert everything to nsec.
>> 
>> Well - a spi_device driver does not actually know what is the
>> actual spi clock configured/used by the spi-bus-driver.
> 
> Which slave device and driver are we talking about anyway?
> Is the driver actually making use of the ability to change the
> speed per-transfer?  Most slaves I've dealt with so far use a
> constant speed.  In that case the master driver could set the
> slave's ->speed_hz member to the effective speed on ->setup()
> and the slave's driver could then calculate the delay in nsec
> or usec based on that speed.

Unfortunately this is not always the case...

Some devices - like the mcp2517fd -  have for example an internal PLL
based on an external clock. So during setup you have to use speed_hz 
of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we 
may be using speed_hz from the dt (or less if a module parameter is
used to limit ourselves further)

So the initial setup would not be able to help here - and every
bus controller would now be required to implement setup.

It also means open coding the calculations in each driver that 
needs something like this.

Thus it is - imo - in the right location to support it in spi core.

This is also the reason why I was asking if the same argument
for a multiple of SCKs may apply also to delay_us.

An ADC spi-slave would be an example where this could be needed
to keep the spi bus quiet during sampling - I remember having
seen one datasheet where cs was required to remain asserted
during sampling and after X SCK cycles the conversion could get read.

> 
>> All it knows is that the device requires X clock cycles of cs high.
> 
> That's what I was driving at with my "to what end?" question.  You've
> apparently got a slave device that requires a delay of a specific number
> of clock cycles.  You should make that explicit in the commit messages,
> ideally by naming the slave that requires it.  Right now your commit
> messages only explain the "what", not the "why".  For an uninitiated
> reader it's helpful to understand the specific motivation of your code
> changes.

I will make that commit message clearer in case a new version of 
the patchset is needed for other reasons.

Thanks,
	Martin
