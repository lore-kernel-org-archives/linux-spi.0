From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: convert to using core message queue
Date: Wed, 18 Apr 2012 14:20:47 +0200
Message-ID: <CACRpkdY8hexQnAao+jqRcFBD+ofwhKghOuBN2VE_GZi7bQ4jzA@mail.gmail.com>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
	<20120315092923.951203E04FD@localhost>
	<CACRpkdZNQZyx-HZjzyMctpUQJtNYMwq5KsdE6RTFwKcHuz_X+w@mail.gmail.com>
	<Pine.LNX.4.64.1203170036590.20979@axis700.grange>
	<CACRpkdZFobGAqO-8xe_JqA9stc=S6SHBCNEN4DSXy1AN5Ro8HQ@mail.gmail.com>
	<20120320144054.930D03E2834@localhost>
	<Pine.LNX.4.64.1204112254420.10361@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1204112254420.10361-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 11, 2012 at 10:56 PM, Guennadi Liakhovetski
<g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> Hi Grant
> On Tue, 20 Mar 2012, Grant Likely wrote:
>
>> On Mon, 19 Mar 2012 00:33:14 +0100, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>> > On Sat, Mar 17, 2012 at 12:39 AM, Guennadi Liakhovetski
>> > <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
>> >
>> > > The SPI subsystem core now manages message queues internally. Remove=
 the
>> > > local message queue implementation from the spi-bitbang driver and
>> > > migrate to the common one.
>> > >
>> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
>> >
>> > This is great stuff!
>> > Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >
>> > (Since I've never really used the bitbang driver I wouldn't trust me to
>> > do any deeper review.)
>>
>> In hindsite; I should have asked you to make the pl driver use bitbang
>> queueing since that was already used for generic queuing by a number
>> of drivers; and then refactored that to perform better. =A0Doing that
>> would have been refactoring better tested code, but oh well.
>>
>> I'm going to ignore this series for the moment; please remind me to
>> look at it after the merge window has closed.
>
> Seems to be time:-)

Yeah lets ping Grant on this :)

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
