From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4] xilinx_spi: Splitted into
	generic, of and platform driver, added support for DS570
Date: Tue, 10 Nov 2009 09:44:30 -0700
Message-ID: <fa686aa40911100844q19789297h8e6713e915185a7@mail.gmail.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
	<4AF99298.9020207@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4AF99298.9020207-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 10, 2009 at 9:19 AM, Richard R=F6jfors
<richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org> wrote:
> Grant Likely wrote:
>> Oops, I replied to the original version, but missed the subsequent
>> versions. =A0Looks like some of my comments still apply though.
>> Overall, the patch changes too many things all at once. =A0You should
>> look at splitting it up. =A0At the very least the io accessor changes
>> should be done in a separate patch.

Hi Richard.  Please do another spin of this patch.  I don't have any
particular problem with the changes, but it needs to be in a more
granular form so I can review it properly.

>>> +struct xilinx_spi {
>>> + =A0 =A0 =A0 /* bitbang has to be first */
>>> + =A0 =A0 =A0 struct spi_bitbang bitbang;
>>> + =A0 =A0 =A0 struct completion done;
>>> + =A0 =A0 =A0 struct resource mem; /* phys mem */
>>> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0/* virt. address of the con=
trol registers */
>>> + =A0 =A0 =A0 u32 irq;
>>> + =A0 =A0 =A0 u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the Tx =
buffer */
>>> + =A0 =A0 =A0 const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buffer=
 */
>>> + =A0 =A0 =A0 int remaining_bytes; =A0 =A0/* the number of bytes left t=
o transfer */
>>> + =A0 =A0 =A0 /* offset to the XSPI regs, these might vary... */
>>> + =A0 =A0 =A0 u8 bits_per_word;
>>> + =A0 =A0 =A0 bool big_endian; =A0 =A0 =A0 =A0/* The device could be ac=
cessed big or little
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* endi=
an
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> +};
>>> +
>>
>> Why is the definition of xilinx_spi moved?
>
> I liked the idea of heaving the struct defined in the top of the file.

... which is completely unrelated to the patch purpose, and is not
mentioned in the patch header.  If you really want to move it then put
it in a completely separate patch and describe the change properly.
As it is right now it is just noise that makes the stated purpose of
the patch hard to review.

>> Ah, you changed these to functions instead of macros. =A0I like.
>> However, as you suggested elsewhere in this thread, you could change
>> these to callbacks and then eliminate the if/else statements. =A0I think
>> that is the approach you should use. =A0I don't think you need to worry
>> about it being slower. =A0Any extra cycles for jumping to a callback
>> will be far dwarfed by the number of cycles it takes to complete an
>> SPI transfer.
>
> Sure that can be updated. I prefer to do that in an incremental patch, wo=
uld be great to get this
> big one merged first.

As already commented on, this patch is too big and does too many
unrelated things.  Please split into discrete changes so it can be
reviewed properly.

Thanks,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
