From: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Why does MOSI appear to be sending data on a read?
Date: Wed, 11 Jan 2012 23:27:30 +0000
Message-ID: <CAN=k24nN=QTiym1uCeG=GmRgrKgcJfowDvr0pMsOreN51cT8dA@mail.gmail.com>
References: <CAN=k24mOrOe939_iWS2cO-1nTH0jGy5DjWDd0tdRwGJqvGg2TQ@mail.gmail.com>
	<20120111183908.GA1700@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120111183908.GA1700-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 11, 2012 at 6:39 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Wed, Jan 11, 2012 at 05:21:24PM +0000, Wayne Tams wrote:
>> Hi,
>>
>> Just wondering if this is normal behaviour. When I do a SPI read to my
>> slave device I get the data I want all seems fine.
>>
>> When I look at the SPI bus on a logic analyser, after I write to MOSI
>> to tell the device I am going to read I can see that my MOSI line has
>> the same number bytes as those being read on MISO only that they are
>> all NULL.
>
> All SPI transfers are bidirectional. =A0For every bit clocked out you wil=
l get a bit clocked in.

The opposite will be the same. For bit clocked in a bit is clocked out.

Thanks for clarifying that for me.

Wayne

Thanks.
>
> g.
>
>>
>> Thanks
>>
>> Wayne
>>
>> ------------------------------------------------------------------------=
------
>> Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
>> infrastructure or vast IT resources to deliver seamless, secure access to
>> virtual desktops. With this all-in-one solution, easily deploy virtual
>> desktops for less than the cost of PCs and save 60% on VDI infrastructure
>> costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
>> _______________________________________________
>> spi-devel-general mailing list
>> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
