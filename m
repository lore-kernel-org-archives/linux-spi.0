From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device()
	to allow two stage registration.
Date: Sat, 24 May 2008 00:54:29 -0600
Message-ID: <fa686aa40805232354g147acfcdx4753fce1a448ceb7@mail.gmail.com>
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

Question:  spi_alloc_device() (and the original code) does a
spi_master_get() on the spi_master device.  Doesn't spi_master_put()
need to be called when the device is discarded?  spi_dev_put() doesn't
do that explicitly; is it an implicit operation after a device has
been deregistered from the spi_master?

Thanks,
g.

>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
