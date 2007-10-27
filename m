From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
 core learns about SPI
Date: Sat, 27 Oct 2007 14:08:23 +0200
Message-ID: <20071027140823.5d7ec7e2@poseidon.drzeus.cx>
References: <200708080906.18993.david-b@pacbell.net>
	<20070829092247.GA15021@pengutronix.de>
	<20070829165243.0236cc89@poseidon.drzeus.cx>
	<200708290943.59450.david-b@pacbell.net>
	<470A644A.8030405@gmail.com>
	<20071010203613.55676dba@poseidon.drzeus.cx>
	<c4bc83220710190240wd13bfd1r991ba9b1b1128f6c@mail.gmail.com>
	<c4bc83220710190250m6c3401end194917e2daa9104@mail.gmail.com>
	<20071022203428.300117e4@poseidon.drzeus.cx>
	<471DAB71.8000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <471DAB71.8000808-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On Tue, 23 Oct 2007 10:06:09 +0200
Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Pierre Ossman wrote:
> > Ah. I see what you mean now. The problem is in the data transfer, not a response field. So Sacha's patch was almost correct. Could you test if the included patch solves your issue?
> 
> With your patch it works as good as with the one from Sascha.
> 

Great. I'll send it to Linus then.

(Just in case it wasn't apparent, my patch was different from Sascha's as his flipped some stuff that shouldn't)

> > 
> > Is this really a problem that plagues you, or just something you noticed in the code?
> 
> It is that we need to suspend as soon as possible because of power loss.
> Waiting to flush all the caches does not help, because there will not be
> enough time with backup power. So it's better not to start any new block
> requests to safe as much backup power as possible and to avoid
> interrupted block transfer.
> 

Ah, that is a very good point. Could I bother you with having a look at how other parts of the kernel does things?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
