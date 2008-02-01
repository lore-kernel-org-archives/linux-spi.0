From: "Bryan Wu" <cooloney.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] [Blackfin] SPI driver updates
Date: Fri, 1 Feb 2008 17:41:14 +0800
Message-ID: <386072610802010141g340cdb14gcd244ab87ffc855e@mail.gmail.com>
References: <1201684421-26124-1-git-send-email-bryan.wu@analog.com>
	<200801311250.46415.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801311250.46415.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Feb 1, 2008 4:50 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> I've forwarded these to Andrew, with my signoff and updated comments.
> You still need to work on having your patch descriptions match up
> to what the patches actually do...
>

Thanks a lot, I will try to make it more clearer next time.

> Patches 3-5 in this series seem to have a common thread:  waiting
> until BIT_STAT_SPIF is set before moving to the next step of the
> transfer.  Next time something similar happens, I'd rather see just
> one patch addressing the issue on all code paths ... not three small
> patches that only fix it for a few of the code paths.
>

OK, I will try to merge these same bug fixing into one patch.

> Also, two of those three patches describe their updates as fixing
> a "regression", or "reverting" the code.  Was this a bug that came
> in those patches you wanted to merge to 2.6.24?  If so, shouldn't
> those regression fixes go into the stable series?
>

Yes, I agree with you. Actually, I intend to send out these bug fixing
patch ASAP, but we want to make sure our tester verify this bug was
fixing first.

Thanks
-Bryan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
