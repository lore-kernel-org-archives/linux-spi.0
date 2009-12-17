From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx_spi: Fix up I/O routine
	wrapping bogosity.
Date: Thu, 17 Dec 2009 09:01:25 -0800
Message-ID: <fa686aa40912170901p6af26715l5f009ba96d1e1341@mail.gmail.com>
References: <20091216060130.GD31265@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org,
	John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091216060130.GD31265-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 15, 2009 at 10:01 PM, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> wrote:
> xilinx_spi presently makes some fairly questionable assumptions about I/O
> routines, and attempts to assign ioread32/iowrite32 and friends directly
> to its own internal function pointers. On many platforms these I/O
> routines are macros or wrappers and not actual functions on their own,
> resulting in things like:
>
> ERROR: "ioread32be" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "iowrite32be" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "iowrite32" [drivers/spi/xilinx_spi.ko] undefined!
> ERROR: "ioread32" [drivers/spi/xilinx_spi.ko] undefined!

Unfortunately, ARM doesn't have either ioread32be or iowrite32be
defined, so the problem is still not solved with this patch.  I've
crafted a patch to add them which I'll send to the ARM list right now.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
