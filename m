From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: bitbang: convert to using core message queue
Date: Tue, 8 Jan 2013 13:50:50 +0100
Message-ID: <CACRpkdYAP8L3jut_udzaTBG-gJZ3Po9E2kgY+Wttw=jksG9d7w@mail.gmail.com>
References: <Pine.LNX.4.64.1205211319520.30522@axis700.grange>
	<Pine.LNX.4.64.1205211324370.30522@axis700.grange>
	<20120525232949.753D43E0BAA@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120525232949.753D43E0BAA@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, May 26, 2012 at 1:29 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Mon, 21 May 2012 13:25:23 +0200 (CEST), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
>> The SPI subsystem core now manages message queues internally. Remove the
>> local message queue implementation from the spi-bitbang driver and
>> migrate to the common one.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
>
> Okay, I'm going to be really nitpicky here.  The change is fine, but the
> diff is too big; particularly for anyone trying to figure out what has
> changed if it causes breakage.  I wouldn't worry about this as much
> for an individual driver, but spi_bitbang is common infrastructure.

Did this ever get around to get fixed? I guess not....

Guennadi, are you going to fix the patch according to Grant's
requests or should I try to clean it and resubmit? The problem
is that I have no real way of testing this. But if I break something
I guess people will notice :-D

Yours,
Linus Walleij

------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
