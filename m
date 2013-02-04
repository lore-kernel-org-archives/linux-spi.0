From: Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
	370/XP
Date: Mon, 4 Feb 2013 17:01:45 -0300
Message-ID: <CALF0-+XPDLeSYBFO6sQ2M24F1f5pgz8tSNMm0VX8BEeda3ym+g@mail.gmail.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130204165119.GA2440@localhost>
	<20130204183733.GM14746@titan.lakedaemon.net>
	<20130204192914.GA2456@localhost>
	<20130204194714.GN14746@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130204194714.GN14746-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Jason,

On Mon, Feb 4, 2013 at 4:47 PM, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org> wrote:
> Ezequiel,
>
> On Mon, Feb 04, 2013 at 04:29:15PM -0300, Ezequiel Garcia wrote:
>> On Mon, Feb 04, 2013 at 01:37:33PM -0500, Jason Cooper wrote:
>> > On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
>> > > The patches are based in Jason Cooper's mvebu/dt branch.
>> >
>> > It probably doesn't matter for this series (I haven't tried to apply it
>> > yet), but please base future work off of a mainline tag (eg v3.8-rc6).
>> > It makes merge conflicts easier to resolve.
>> >
>> > Feel free to test-merge against the mvebu/ branches and let me know of
>> > any conflicts.
>> >
>>
>> Ah, I see.
>>
>> I was mistakenly assuming you wanted against that branch;
>> I'll base the patches on mainline in the future.
>
> Nope, the branches are organized that way to sanely merge in with all
> the other arm-soc code.  While I make every effort to keep them stable
> (ie, not rebased), they may change at anytime if I need to fix things.
>
> tags are stable, and if all patches are based on tags, then merge
> conflicts follow a predictable pattern.  Anything else devolves into
> chaos.
>

Ah=E1... this explains why I was seeing your branches rebased! ;-)

>> > Also, your patch series appears to be out of order, did you use git
>> > send-email once per file?
>>
>> I always send the cover letter manually. This time I did it after the pa=
tches.
>> I'm in the process of automating this in my workflow,
>> but feel free to make a suggestion.
>
> if format-patch is called properly (I know from experience how to call
> it improperly ;-) ), you can just do
>
> $ git send-email ... /path/to/patches/*.patch
>
> and it'll get the order correct.  It will also ask for confirmation
> before sending each email.
>
> Dry-run sending a series just to yourself lets you see how it will
> appear once it goes out to the list.
>

Okey, great. Thanks for the advices!

-- =

    Ezequiel

---------------------------------------------------------------------------=
---
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
