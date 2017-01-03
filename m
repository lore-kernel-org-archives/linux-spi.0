From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v2 2/2] MIPS: BMIPS: Add support SPI device nodes
Date: Tue, 3 Jan 2017 17:36:54 +0900
Message-ID: <980BB972-94D0-4466-A888-3B65FBC5C851@gmail.com>
References: <20161230063001.944-1-jaedon.shin@gmail.com>
 <20161230063001.944-3-jaedon.shin@gmail.com>
 <09536633-9c81-9621-36af-665369e97a78@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <09536633-9c81-9621-36af-665369e97a78-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Florian,

> On 1 Jan 2017, at 3:42 AM, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> Hi Jaedon,
> 
> On 12/29/2016 10:30 PM, Jaedon Shin wrote:
>> Adds SPI device nodes to BCM7xxx MIPS based SoCs.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
> 
>> +
>> +&qspi {
>> +	status = "okay";
>> +
>> +	m25p80@0 {
>> +		compatible = "m25p80";
>> +		reg = <0>;
>> +		spi-max-frequency = <0x2625a00>;
> 
> Sorry for not noticing this earlier, can we have the frequency in a
> decimal form?

I will change to "spi-max-frequency = <40000000>" in v3.

Thanks,
Jaedon

> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Thanks!
> -- 
> Florian

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
