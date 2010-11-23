From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: spi/spi: don't release the spi device twice
Date: Tue, 23 Nov 2010 22:24:00 +0800
Message-ID: <20101123222400.7cdf3074@feng-i7>
References: <20101122133503.GA25553@www.tglx.de>
	<20101123004301.GA1034746@jupiter.n2.diac24.net>
	<4CEB985F.90805@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CEB985F.90805-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sebastian,

On Tue, 23 Nov 2010 18:33:03 +0800
Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> David Lamparter wrote:
> > This code is the old code, before patch 3486008 which you're citing.
> > 3486008 does:
> > 
> > -       dummy = device_for_each_child(master->dev.parent,
> > &master->dev,
> > -                                       __unregister);
> > +       dummy = device_for_each_child(&master->dev, NULL,
> > __unregister);
> > 
> > Considering that this patch is in 2.6.36 (and 36.1), you seem to
> > have mixed up your sources. Please make sure your checkout is
> > current and unbroken...
> Hmmm.
> # git describe --long
> v2.6.37-rc3-0-g3561d43
> 
> After looking at spi_unregister_master() in drivers/spi/spi.c, I see:
> 
>       dummy = device_for_each_child(master->dev.parent, &master->dev,
>                       __unregister);
>       device_unregister(&master->dev);
>   }
> 
> This change got back in by:
> 
> commit 2b9603a0d7e395fb844af90fba71448bc8019077
> Author: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date:   Mon Aug 2 15:52:15 2010 +0800
> 
>      spi: enable spi_board_info to be registered after spi_master
> 
> which is v2.6.37-rc1~2^2~4. So I probably mixed up you with Feng.
> 
> This thread starts at
> http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg05437.html
> 
I checked my original patch which didn't touch the logic of spi_unregister_master() as
-----------------------------------------
@@ -568,6 +592,10 @@  void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
+	mutex_lock(&board_lock);
+	list_del(&master->list);
+	mutex_unlock(&board_lock);
+
 	dummy = device_for_each_child(master->dev.parent, &master->dev,
 					__unregister);
 	device_unregister(&master->dev);
-----------------------------------------

So this should be a merge problem, which corrupt the commit from David's commit
3486008 "spi: free children in spi_unregister_master, not siblings"

Thanks,
Feng

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
