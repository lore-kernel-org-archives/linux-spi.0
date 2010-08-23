From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace
	existing driver
Date: Mon, 23 Aug 2010 15:00:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E8350E47@dbde02.ent.ti.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<201008201406.33473.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E8350B45@dbde02.ent.ti.com>
	<201008231154.10411.caglarakyuz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201008231154.10411.caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 23, 2010 at 14:24:10, Caglar Akyuz wrote:
> On Monday 23 August 2010 07:28:48 am Nori, Sekhar wrote:
> > Hi Caglar,
> >
>
> Hi,
>
> [...]
>
> > I have been spending time on this (admittedly on and off) since I wrote
> >  that email and have broken down the work into ~20 patches so far. Starting
> >  to scratch the DMA related changes right now. So, I guess I am somewhere
> >  midway.
> >
> > I pushed a branch containing the work so far here:
> >
> > http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=ref
> > s/heads/davinci-spi-rewrite
> >
>
> This is great.
>
> > This isn't tested or submit-worthy yet. I was hoping to break down the
> > complete work, test it and get reviewed by Brian. Also, the final work
> > may differ from Brian's work slightly as I did some improvements while
> > I was the fat patch breaking down.
> >
> > The breakdown wasn't mechanical because Brian's improvements are very
> > intertwined and if I just simply 'selected hunks' it wouldn't make for
> > a very reviewable patch series.
> >
>
> I was hoping to reach to an exact copy of Brian's version since that version
> is tested by Brian and some others. but if you say so...

Yeah, that was my initial goal too. Anyway, at the end of it we can review
the delta separately and make sure the changes are worth making and don't
actually break functionality.

Thanks,
Sekhar


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
