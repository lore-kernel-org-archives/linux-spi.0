From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: controller_data handling through spidev.c
Date: Tue, 31 Aug 2010 08:05:14 -0700 (PDT)
Message-ID: <362524.36146.qm@web180304.mail.gq1.yahoo.com>
References: <9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	MathieuXSoulard <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018810CF7F496-IGOiFh9zz4x9qrmMLTLiibfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



--- On Tue, 8/31/10, Soulard, MathieuX <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> =

> ... Actually some SPI controller drivers handle a
> specific spi_device.controller_data as input in their setup
> operation, and the controller driver I'm testing uses this
> field in its setup operation, if provided.
> =

> The driver spidev.c handles many commands through ioctl but
> it does not provide a way to setup a specific
> controller_data.

And it shouldn't, any more than platform_data.


> =

> I would like to get your opinion about this field usage
> from the protocol driver, since I'm not sure to understand
> the way this field has be used: is it really supposed to be
> used by the protocol driver to deliver some controller's
> specific setup, or, is it a field we should ignore from the
> protocol driver perspective as

Ignore it.


It's a sibling to the platform_data field, and
should be set up with that.  Neither one should
be assigned or understood by protocol drivers.

Historically, controller_data was used ISTR to
cope with tuning that the PXA SPI controller
required (DMA etc).  Most controllers should
have no need for it.



 it is supposed to be only
> managed by the controller driver if it needs it ?
> =

> Then, I would like to get your opinion about the attached
> patch I'm using to get an access to controller_data from the
> user space. I wrote this patch since the SPI driver I'm
> testing handles a specific spi_device.controller_data in its
> setup operation. It allows me to provide it from user space
> through spidev.c.
> =

> =

> Thanks
> Regards
> =

> Mathieu
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock
> company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> =

> 92196 Meudon Cedex, France
> Registration Number:=A0 302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> =

> This e-mail and any attachments may contain confidential
> material for
> the sole use of the intended recipient(s). Any review or
> distribution
> by others is strictly prohibited. If you are not the
> intended
> recipient, please contact the sender and delete all
> copies.
> =

> -----Inline Attachment Follows-----
> =

> -------------------------------------------------------------------------=
-----
> This SF.net Dev2Dev email is sponsored by:
> =

> Show off your parallel programming skills.
> Enter the Intel(R) Threading Challenge 2010.
> http://p.sf.net/sfu/intel-thread-sfd
> -----Inline Attachment Follows-----
> =

> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> =



---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
