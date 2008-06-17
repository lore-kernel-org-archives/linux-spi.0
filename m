From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device()
	to allow two stage registration.
Date: Tue, 17 Jun 2008 01:28:26 -0600
Message-ID: <fa686aa40806170028t2ccb679k22d2d3cea793ebc1@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193608.28030.34968.stgit@trillian.secretlab.ca>
	<200805211717.13206.david-b@pacbell.net>
	<fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805232343x20031560j5659d203e25f494-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

On Sat, May 24, 2008 at 12:43 AM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Wed, May 21, 2008 at 6:17 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>> On Friday 16 May 2008, Grant Likely wrote:
>>>
>>> This patch splits the allocation and registration portions of code out
>>> of spi_new_device() and creates three new functions; spi_alloc_device(),
>>> spi_register_device(), and spi_device_release().
>>
>> I have no problem with the first two, but why the last?
>>
>> If the devices are always allocated by spi_alloc_device() as
>> they should be -- probably through an intermediary -- the
>> only public function necessary for that cleanup should be
>> the existing spi_dev_put().
>
> Ah, okay.  I'm still a bit fuzzy on the device model conventions.
> I'll remove that then.

I've dug into this some more.  spi_alloc_device only allocates the
memory.  It doesn't call device_initialize() to initialize the kref.
All of that behaviour is handled within device_register().  Therefore
if a driver uses spi_alloc_device() and then if a later part of the
initialization fails before spi_register_device() is called, then the
alloc'd memory needs to be freed, but spi_dev_put() won't work because
the kobj isn't set up so I need another function to handle freeing it
in on a failure path.

Should I switch things around to do device_initialize() in the alloc
function and call device_add() instead of device_register() in the
spi_register_device() function?  Is that sufficient to make
put_device() work?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
