From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the
	OF device tree and add mpc5200-spi driver
Date: Fri, 16 May 2008 16:27:33 -0400
Message-ID: <9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080516193054.28030.35126.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
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

On 5/16/08, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> This series is a set of changes to allow the slaves on an SPI bus to be
>  described in the OF device tree (useful in arch/powerpc) and adds a driver
>  that uses it (the Freescale MPC5200 SoC's SPI device).

Right now we have SPI hooked up to PSC3. Hardware engineer is gone but
I'll see if I can get him to alter things to use the SPI controller. I
have an old mail from him where he thinks the Phytec board is missing
a signal needed to use the SPI controller.

Is the current SPI driver working on PSC3? I have a MMC card wired up
to it but I've never tried using it.

I have the MPC5200 PSC SPI driver enabled and "MMC/SD over SPI"
enabled in my kernel. The MMC bus gets created but there aren't any
devices on it. Do we need something in the SPI driver so that the MMC
layer can find it?

Are you going to keeps this as two drivers or merge them? If it is two
drivers there should be one entry in Kconfig and two sub choices for
the types of drivers.

>  Please review and comment.  David, I've included in this series my earlier
>  patch to change modalias from a pointer to a string as one of the later
>  patches depends on it.
>
>  Cheers,
>  g.
>
>
>  --
>  Grant Likely, B.Sc. P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
