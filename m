From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus number
 via dts
Date: Wed, 1 Feb 2012 10:57:51 -0700
Message-ID: <CACxGe6u_wWEdoRC0O=bh8UhKG2qE-ZrNtJjULxJVmNTeZkoKvw@mail.gmail.com>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
 <20120201135524.GD13723@sirena.org.uk>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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

On Wed, Feb 1, 2012 at 8:52 AM, Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2012/2/1 Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
>
>>
>> Well, something that walks all block devices on Linux is very
>> straightforward... =A0It sounds like you just want logic along the lines
>> of "find a block device and offer the option of overriding by providing
>> a specific path for use with a file", is that about right?
>>
>
> Well, yes, excepted that the file *is* equivalent to a block device for my
> piece of code!

The answer here is to use the data provided by the kernel to find the
correct device.  Hard coding bus numbers (or any other globally
visible number space for that matter) has all kinds of problems and it
is by design that spi bus drivers are not allowed to choose a bus
number when they are created from DT data.

Instead, your code should either be using udev, or doing the same
thing that udev does to find a specific hardware device.  The uevent
attribute in devices that appear under /dev/bus/spi/devices should be
used to compare with the full device tree path.  I've just written a
patch that should give you the information that you need and I'll cc:
you when I post it.  I'll try to get it merged for v3.4.  This
approach will allow you to find the correct device in a reliable way
that won't be affected by bus numbering changes.

g.
