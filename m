From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: Spi slave devices with two chip selects, how best to handle?
Date: Mon, 29 Nov 2010 12:16:09 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312EFFDE3D@LIMKCMBX1.ad.analog.com>
References: <301691.11173.qm@web180316.mail.gq1.yahoo.com>
	<4CEFC686.30603@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CEFC686.30603-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
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

Jonathan Cameron wrote on 2010-11-26:
> On 11/26/10 04:19, David Brownell wrote:
>>
>>
>> --- On Thu, 11/25/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>
>>>> as to be able to pair them up. Anyone have a better idea or an
>>>> example of what someone else has done in similar circumstances?
>>>
>>> Have a single driver private data structure that contains and
>>> registers 2 spi_device instances.  Have both spi_device instances
>>> point back at the same driver private data structure.

Sorry - I'm not quite sure how this should work, without using a global.
Having a single private data structure is obvious, however spi drivers are
registered and not spi devices. container_of() is not going to help here either.

Can you explain how you would pass the pointer?

>> And consider having a chardev or blockdev to access (indirectly)
>> both the read and write sides of the chip. using that driver-private
>> structure.  ((and, tricky, making the linkage between the three
>> devices visible through the driver model, if you can).
> Thanks all.  This is looking complex enough that I'll probably want to
> actually have the part or leave it to someone who does...
>
> One for your list Michael (I can put suitable element in your tracker
> if that is helpful?)
>
> Jonathan

I'll add a tracker item.
Thanks.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
