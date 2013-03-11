From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-mpc512x-psc: add support for gpio chip
	selects
Date: Mon, 11 Mar 2013 23:45:37 +0100
Message-ID: <20130311234537.2c6ddac8@crub>
References: <1358195221-18488-1-git-send-email-agust@denx.de>
	<1358195221-18488-2-git-send-email-agust@denx.de>
	<20130205141846.173C43E1265@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205141846.173C43E1265@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 05 Feb 2013 14:18:46 +0000
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Mon, 14 Jan 2013 21:27:01 +0100, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> > Currently the driver only uses one internal chip select. Add support
> > for gpio chip selects configured by gpio specifiers in the device tree.
> > 
> > Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> 
> GPIO chip selects are now in the core spi library. Take a look at
> master->cs_gpios and Documentation/devicetree/bindings/spi/spi-bus.txt.
> You don't need to parse them manually.

Thanks for the hint! I'll rework the patch and resubmit.

Anatolij

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
