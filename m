From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message length
Date: Fri, 20 Nov 2015 13:56:13 +0100
Message-ID: <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
References: <564CEB61.2000601@gmail.com> <20151118215755.GL31303@sirena.org.uk> <564D0098.4030107@gmail.com> <20151119114057.GN31303@sirena.org.uk> <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org> <20151119171538.GO31303@sirena.org.uk> <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org> <20151120120502.GT31303@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151120120502.GT31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 20.11.2015, at 13:05, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Fri, Nov 20, 2015 at 11:18:42AM +0100, Martin Sperl wrote:
>>> On 19.11.2015, at 18:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
>>> Please don't do things this way, please make this more data driven =
-
>>> have the drivers declare their capabilities so the core can just do
>>> these things based on those flags rather than requiring active code=
 in
>>> drivers.  This keeps the code central which in turn helps keep thin=
gs
>>> maintainable.
>=20
>> Well - I was thinking about starting with this approach for simplici=
ty.
>=20
>> Making it automatic/data-driven by just defining limits that the cor=
e
>> can then handle transparently is something that could come as a next
>> step.
>=20
> It makes things more complicated in the long run, people start open
> coding things and then making any changes involves changing per-drive=
r
> code and we can't use the information in any way other than the one
> specific way the transformation functions were written.

As said: lets see if it works and passes some logical tests
and then address those things we may want to define on top.

Still there may be different policies that we would need to run for
different spi masters when the transfers are not aligned,
so I wonder if it is really sane to parametrize all those in the
spi_master structure.

>> Also the bus master driver knows what its limitations are, so puttin=
g
>> them inside prepare_message seems reasonable to me - that is unless
>> you really have spi_device drivers that would handle those as separa=
te
>> facts and not refuse to work.
>=20
> Every line of code that's in a driver that could be in the core is a
> maintainence burden, people will want to start doing things like
> combining functions in fun ways and if we want to try to do things li=
ke
> figure out if we can coalesce adjacent transfers in the core (which w=
e
> really ought to) it won't know what the limitations that exist are.
this =E2=80=9Ccolaesce=E2=80=9D of transfers into one could be one of t=
hose=20
=E2=80=9Ctransformation=E2=80=9D I am talking about - and this one woul=
d be implemented
in core making certain assumptions (like starting on a page, ...)

The way I think of it it is actually very simple to implement that.

>>> You've got this back to front - drivers are responsible for initial=
ising
>>> the master when they instantiate it.  There's nothing stopping them
>>> using the data if they have variants to handle but they shouldn't b=
e
>>> speculatively looking at it on the off chance there's some limit.
>=20
>> I wonder if such a variant-construct does not create more headaches =
in
>> the long run as each spi_driver wanting to do something =E2=80=9Csom=
ething=E2=80=9D
>> special would then need to get updated for any additional constraint=
=E2=80=A6
>=20
> I'm sorry but I don't understand what you mean here.  However we
> implement things anything that wants to know about constraints is goi=
ng
> to need to be updated to use them.

That is what I want to avoid if possible - the one thing that may come
handy (at least from my perspective) could be to give some hints to
make optimal use of the HW
Say:
* preferred alignment on X byte boundry
* preferred max spi_transfer.length

All the other possible constraints parameters should be opaque to=20
a spi_device driver, so I would not want to include those inside the
spi_master structure, as _then_ these get used.

That is why I thought of putting those =E2=80=9Cpolicies=E2=80=9D insid=
e
prepare_message on the driver side.

Also the =E2=80=9Crestrictions=E2=80=9D on the spi HW need to get defin=
ed inside the
driver, so there will not be a new =E2=80=9Crestriction=E2=80=9D that a=
pplies to
an existing piece of HW just because we incorporate new options.



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
