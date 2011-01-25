From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] SPI: spi_sh_msiof: cosmetic clean-up
Date: Mon, 24 Jan 2011 22:26:55 -0700
Message-ID: <AANLkTikJm9TEtzFRxYYVXAHgWV68JPamkg5ip6nk1C9h@mail.gmail.com>
References: <Pine.LNX.4.64.1101211654280.18867@axis700.grange>
 <20110121170247.GB7477@angua.secretlab.ca> <20110125050229.GA7183@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110125050229.GA7183@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 24, 2011 at 10:02 PM, Simon Horman <horms@verge.net.au> wro=
te:
> On Fri, Jan 21, 2011 at 10:02:47AM -0700, Grant Likely wrote:
>> On Fri, Jan 21, 2011 at 04:56:37PM +0100, Guennadi Liakhovetski wrot=
e:
>> > 1. sort headers alphabetically
>> > 2. use fixed-size types u8, u16, u32 for register values and trans=
ferred data
>> > 3. simplify some arithmetic operations
>> > 4. remove leading spaces in front of labels
>>
>> There's actually good reason to leave these labels alone. =A0Labels =
in
>> column zero confuse diff and it gives the wrong function name. =A0Fo=
r
>> example:
>>
>> diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
>> index 658bd05..840164b 100644
>> --- a/drivers/spi/spi_sh_msiof.c
>> +++ b/drivers/spi/spi_sh_msiof.c
>> @@ -682,7 +682,7 @@ err2:
>> =A0 =A0 =A0 =A0 clk_put(p->clk);
>> =A0err1:
>> =A0 =A0 =A0 =A0 spi_master_put(master);
>> -err0:
>> + err0:
>> =A0 =A0 =A0 =A0 return ret;
>> =A0}
>>
>> See how the function name in the @@ line is 'err2' instead of
>> sh_msiof_spi_probe() in this example? =A0Indenting the labels by one
>> space is an easy fix and is intentional.
>>
>> I've picked up the patch, but I've dropped the last two hunks.
>
> Surely this is a bug in diff. Or perhaps put more politely,
> diff isn't smart enough to realise a) this is C and b) xxx: isn't
> a valid function name in C.

Oh, perhaps.  But regardless, it is long-standing behaviour and the
single space convention is widely used.  Nobody seems offended enough
by it to go and change diff.  To see, just do:

        git grep '^ [a-zA-Z0-9_]*:'

If it were particularly ugly, or actively dangerous, then I'd be
against this pattern, but it is neither and it noticeably improves
diff readability.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
