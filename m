From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: PRIMA2: use the newest APIs of PINCTRL to fix
	compiling errors
Date: Sat, 19 May 2012 23:17:47 -0600
Message-ID: <20120520051747.7744B3E03B8@localhost>
References: <1337048460-30329-1-git-send-email-Barry.Song@csr.com>
	<CACRpkdYPQW4cTh_j1y4u0wFKkQmgP3oR8E2SJXNSn68jt9pq7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdYPQW4cTh_j1y4u0wFKkQmgP3oR8E2SJXNSn68jt9pq7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 15 May 2012 10:02:01 +0200, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 15, 2012 at 4:21 AM, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org> wrote:
> 
> > From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> >
> > Fix the compiling errors:
> > drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
> > drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
> > drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
> > drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
> > drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
> > drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
> > make[3]: *** [drivers/spi/spi-sirf.o] Error 1
> >
> > Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> > Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Counting on Grant to pick this up...

Applied, thanks.

g.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
