From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [spi][mpc52xx][PATCH] Fix mpc52xx_psc_spi
	master driver
Date: Fri, 25 Jul 2008 09:06:41 -0400
Message-ID: <fa686aa40807250606y670a8419p1e62fe66afe4cc3c@mail.gmail.com>
References: <20080725114341.GB6415@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Luotao Fu" <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080725114341.GB6415-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Fri, Jul 25, 2008 at 7:43 AM, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Hi,
>
> this is a fix for full duplex transfer mode on the mpc52xx_psc_spi driver.
> Details see the patch header. Tested on a mpc5200b board.
>
> Cheers
> Luotao fu

Looks pretty good to me.  I'll pick this up.

For future patches, please send patches inline and not as attachments.
 Attachments mess up the workflow because I cannot comment on the
patch by just hitting 'reply' and it doesn't work with git-am.

g.
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
