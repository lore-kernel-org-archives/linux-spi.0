From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 6/6] SPI: S3C64XX: Consider the clk_from_cmu flag
Date: Wed, 8 Sep 2010 23:55:19 -0600
Message-ID: <20100909055519.GL11833@angua.secretlab.ca>
References: <1283477830-31555-1-git-send-email-jassi.brar@samsung.com>
	<20100909051136.GH11833@angua.secretlab.ca>
	<AANLkTim=_OxGmrvh_eutsc6ugtCBBM_4+yo8X8960Rc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim=_OxGmrvh_eutsc6ugtCBBM_4+yo8X8960Rc0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 09, 2010 at 02:29:22PM +0900, Jassi Brar wrote:
> On Thu, Sep 9, 2010 at 2:11 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> =
wrote:
> > On Fri, Sep 03, 2010 at 10:37:10AM +0900, Jassi Brar wrote:
> >> Newer SoCs have the SPI clock scaling control in platform's
> >> clock management unit. Inorder for such SoCs to work, we need
> >> to check the flag clk_from_cmu before making any clock changes.
> >>
> >> Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >
> > Would it not make sense (or be possible) to roll the current clock beha=
viour into the current clock struct so that this driver can always use the =
same API for dealing with its clocking? =A0Or am I missing something?
> >
> =

> The problem is, earlier SPI had clock control/scaling in it's own IP,
> whereas latest(and in future)
> SPIs have them moved out into the Clock-Management-Unit of the SoC -
> just how it should be.
> In order to have common API, we need to hack clock-api to manipulate
> SPI controller
> registers outside of the SPI driver for older SPIs.... which wouldn't
> be very nice to see.
> any suggestion is welcome, though.

Fair enough, not an ideal situation regardless of the approach.  Your appro=
ach is probably better then.

g.


---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
