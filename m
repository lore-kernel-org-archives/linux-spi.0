From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 0/2] spi: spi-dw: Select 16b or 32b register access
Date: Thu, 05 Mar 2015 23:54:15 +0200
Message-ID: <1425592455.14897.193.camel@linux.intel.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>
		 <1425501868.14897.178.camel@linux.intel.com>
		 <54F7809E.2010307@opensource.altera.com>
	 <1425552233.14897.189.camel@linux.intel.com>
	 <54F8BF6A.70305@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: broonie@kernel.org, grant.likely@linaro.org, jkosina@suse.cz,
	pawel.moll@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, tthayer.linux@gmail.com,
	axel.lin@ingics.com, baruch@tkos.co.il, jg1.han@samsung.com,
	galak@codeaurora.org
To: Thor Thayer <tthayer@opensource.altera.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <54F8BF6A.70305@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2015-03-05 at 14:41 -0600, Thor Thayer wrote:
> Hi Andy,
>=20
> On 03/05/2015 04:43 AM, Andy Shevchenko wrote:
> > On Wed, 2015-03-04 at 16:01 -0600, Thor Thayer wrote:
> >> Hi Andy,
> >>
> >> On 03/04/2015 02:44 PM, Andy Shevchenko wrote:
> >>> On Wed, 2015-03-04 at 14:31 -0600, tthayer@opensource.altera.com =
wrote:
> >>>> From: Thor Thayer <tthayer@opensource.altera.com>
> >>>>
> >>>> The Altera Arria10 SoC requires 32 bit accesses to peripherals. =
The
> >>>> DesignWare SPI peripheral registers are on 32bit boundaries so t=
his
> >>>> patch is minimal. Function pointers are used to select 32bit acc=
ess
> >>>> or 16bit accesses.
> >>>
> >>>
> >>> So, what is exactly the issue when we read only half of the regis=
ter?
> >>> Bus lock, or what?
> >>>
> >>
> >> The read actually works on our chip but I changed both read and wr=
ite to
> >> be consistent. For Arria10, on a 16 bit write the data isn't writt=
en
> >> into the DesignWare register.
> >
> > How did you exactly check this?
> >
>=20
> Sorry, I should have been more clear. The architecture of the Arria10=
=20
> SoC enforces 32 bit writes - even for the APB bus. The Arria10's=20
> interconnect only allows 32 bit writes.

Hmm=E2=80=A6 So, reads are okay, but writes are 32 bit only? Have you a=
ny link
to the documentation where I could read this?

> As a result, the solution below doesn't work for us.

My thought was about post writes. That's why I was wondering and still
wonder if something to clarify in the documentation.=20

>=20
> I do have a much cleaner patch to re-submit but I haven't applied it =
on=20
> top of your patches yet & tested yet.

Okay, please, apply the above as a part of commit message.
I also would like to test it on Intel Medfield.

>=20
> >>
> >> In reply to your other email, yes it does support the DW_apb_ssi b=
ut the
> >> Arria10 architecture requires 32 bit access (actually as you point=
 out,
> >> 32 bit writes). We're using the original driver on our older chips=
 but
> >> Arria10 requires upstream changes.
> >
> > Can you check if the following helps in your case:
> >
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -170,6 +170,8 @@ static inline u16 dw_readw(struct dw_spi *dws, =
u32 offset)
> >   static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 =
val)
> >   {
> >          __raw_writew(val, dws->regs + offset);
> > +       mmiowb():
> > +       __raw_readw(dws->regs + offset);
> >   }
> >
> >   static inline void spi_enable_chip(struct dw_spi *dws, int enable=
)
> >


--=20
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

