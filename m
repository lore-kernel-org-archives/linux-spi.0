From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: don't treat NULL clk as an error
Date: Mon, 10 Jan 2011 16:24:17 -0700
Message-ID: <AANLkTinOWvu5TNMtsrw19-ERc1JpopvQkyp0QH3sQpkL@mail.gmail.com>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
	<20110110221802.GD12552@n2100.arm.linux.org.uk>
	<20110110222524.GE12552@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110110222524.GE12552-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 10, 2011 at 3:25 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Mon, Jan 10, 2011 at 10:18:02PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Jan 10, 2011 at 01:58:12PM -0700, Grant Likely wrote:
>> > On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org> wrot=
e:
>> > > Some platforms have been known to return NULL from clk_get() if they
>> > > support only a single struct clk. =A0Whilst tegra doesn't do this, m=
ake
>> > > the drivers consistent with others.
>> > >
>> > > Cc: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
>> > > Signed-off-by: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
>> >
>> > Hi James,
>> >
>> > If NULL does get returned, say due to a future change to the clock
>> > code, then this change causes the driver to oops. =A0I'm not going to
>> > apply this patch.
>>
>> Please apply it - the clock API just defines struct clk as a cookie
>> where errors are IS_ERR/PTR_ERR. =A0Other values must be considered by
>> drivers as perfectly valid, including NULL.
>
> Also note that drivers have no business ever dereferencing struct clks.
> So if they oops, that's their own fault for dereferencing something
> that they shouldn't.

I was actually looking at the implementation of clk_enable() which is
called by the driver and doesn't do any NULL checking.  But I suppose
that it then becomes the clock-code's own fault if it returns NULL and
then oopses on a NULL being passed to it.  Okay, I'll apply it.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Gaining the trust of online customers is vital for the success of any compa=
ny
that requires sensitive data to be transmitted over the Web.   Learn how to =

best implement a security strategy that keeps consumers' information secure =

and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl =
