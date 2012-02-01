From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus
 number via dts
Date: Wed, 1 Feb 2012 18:10:37 +0000
Message-ID: <20120201181037.GB24063@sirena.org.uk>
References: <20120201135524.GD13723@sirena.org.uk>
 <CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
 <20120201140838.GE13723@sirena.org.uk>
 <CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
 <20120201143558.GF13723@sirena.org.uk>
 <CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
 <20120201150517.GG13723@sirena.org.uk>
 <CAMVnO+kvjbxW7EdMe_YF=oSp0bR-RqaP_rPM57tyHzGKhsoNxg@mail.gmail.com>
 <20120201154204.GH13723@sirena.org.uk>
 <CAMVnO+nB77XOQHfL1zZLve_=z6vFk_HMF+hj=iMTAuOAYSRExA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMVnO+nB77XOQHfL1zZLve_=z6vFk_HMF+hj=iMTAuOAYSRExA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 01, 2012 at 04:52:14PM +0100, Frederic LAMBERT wrote:

> Yes, that seems simple said like that.
> It was thus more simple for me, at that time, to modify a specific driver
> for a specific port (Nios2), than to modify a core used by every one.
> Question of time, and confidence in my own capacities :-).
> The other point being the change acceptation (and the time it takes) by the
> community...

In this case doing something generic would be easier to get merged
(modulo the "don't do that" issue) - people are being a lot more wary
about driver specific changes that should be generic than they used to
be.
