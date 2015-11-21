From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message length
Date: Sat, 21 Nov 2015 16:57:01 +0100
Message-ID: <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
References: <564CEB61.2000601@gmail.com> <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com> <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org> <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org> <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org> <20151121134946.GI26072@sirena.org.uk>
 <56507B3B.4080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56507B3B.4080608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21 November 2015 at 00:22, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> On Fri, Nov 20, 2015 at 08:05:48PM +0100, Michal Suchanek wrote:

>> If it's desirable that a partial transfer is reported as error then =
a
>> particular error value should be defined for this case and drivers
>> that can continue the transfer in a driver-specific way (such as
>> spi-nor) can check for this error and handle it appropriately and pa=
ss
>> through any other error.
>
> Based on Mark's further comments (and my own intuition), I'd rather n=
ot
> try to interpret different error codes to mean "truncated but keep
> going" vs. "truncated for other reason, stop now", unless we really h=
ave
> to.
>
> I think if we do what Heiner was proposing from the beginning -- expo=
se
> a reasonable max SPI message length -- then I think we'll cover the b=
ulk
> of what we want. SPI NOR drivers can then try "small enough" transfer=
s,
> and if we see any errors, those are unexpected, and we abort.
>
> Sound OK?

It sounds ok.

We actually have use case for both cases even in spi-nor.

Write transfers a page at a time and when whole page cannot be written
an error should be reported and propagated. When the master controller
cannot write like 260 bytes at once the flash becomes effectively
read-only.

Read can do arbitrary size blocks so the limit should be checked and
the transfer done in appropriately sized chunks.

On 21 November 2015 at 00:07, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:

>> 64k limit on the other hand is something more usable from driver
>> writer standpoint and some banked mmap access to flash memories woul=
d
>> have similar granularity.
>
> Right.
>
>> I would also like to point out that the limit depends on the transfe=
r
>> settings. For example, a SPI controller can have no limit on transfe=
r
>> size but when accessing a flash memory through mmap interface the mm=
ap
>> window limits the amount of data you can transfer at once. This
>> particular case may be fixable by moving the mmap window transparent=
ly
>> inside the driver.
>
> Hmm, I'm not sure I have much opinion on that one without having a
> non-theoretical case. It seems like it'd be best if the SPI master
> driver can work as best as it can to respect a single reasonable "max
> mesage size", even if that means choosing the lowest common denominat=
or
> of all limitations.

I don't have an actual example either. All the cases I can think of
fall into two categories

1) it can be handled transparently
2) something is broken

maybe master driver could recalculate the limit when the transfer
parameters are changed if really needed.

On 21 November 2015 at 15:10, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Am 21.11.2015 um 14:49 schrieb Mark Brown:
>> On Fri, Nov 20, 2015 at 01:56:13PM +0100, Martin Sperl wrote:
>>
>>>> Every line of code that's in a driver that could be in the core is=
 a
>>>> maintainence burden, people will want to start doing things like
>>>> combining functions in fun ways and if we want to try to do things=
 like
>>>> figure out if we can coalesce adjacent transfers in the core (whic=
h we
>>>> really ought to) it won't know what the limitations that exist are=
=2E
>>
>>> this =E2=80=9Ccolaesce=E2=80=9D of transfers into one could be one =
of those
>>> =E2=80=9Ctransformation=E2=80=9D I am talking about - and this one =
would be implemented
>>> in core making certain assumptions (like starting on a page, ...)
>>
>> Why would we want to force that assumption?  It massively reduces th=
e
>> utility for DMA controllers that don't have such limitations.
>>
>>>>> I wonder if such a variant-construct does not create more headach=
es in
>>>>> the long run as each spi_driver wanting to do something =E2=80=9C=
something=E2=80=9D
>>>>> special would then need to get updated for any additional constra=
int=E2=80=A6
>>
>>>> I'm sorry but I don't understand what you mean here.  However we
>>>> implement things anything that wants to know about constraints is =
going
>>>> to need to be updated to use them.
>>
>>> That is what I want to avoid if possible - the one thing that may c=
ome
>>> handy (at least from my perspective) could be to give some hints to
>>> make optimal use of the HW
>>> Say:
>>> * preferred alignment on X byte boundry
>>> * preferred max spi_transfer.length
>>
>>> All the other possible constraints parameters should be opaque to
>>> a spi_device driver, so I would not want to include those inside th=
e
>>> spi_master structure, as _then_ these get used.
>>
>> You're conflating two unrelated design decisions here.  Yes, it's
>> unfortunate that the SPI API was written to allow client drivers to =
see
>> the master structure but that doesn't mean that converting data into
>> code is a good idea, that's still a bad pattern independently of the
>> visibility issue.
>>
> Currently the only (?) way for a protocol driver like spi-nor to get
> info about HW restrictions described in the controller driver
> is via the master structure and its "constraint" members.
>
> As you say this visibility of the master structure is unfortunate:
> What could be a (maybe long-term) better way to propagate restriction=
s
> that can't be handled transparently in the core like max message size
> and SPI NOR to protocol drivers?
>

Actually, the fact that the maximum size of SPI transfer can be
limited is a fact which was already observed by some protocol driver
writers and handled in a driver-specific way. So adding this to the
core makes sense.

In most cases you practically cannot hit the limit because it is very
large. In the cases when some practically feasible transfer can trip
the limit it should be reported as master limitation.

As the possibility to coalesce something is protocol-specific the
protocol driver is in the position to make decision how a limitation
should be handled and should know about the limitation.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
