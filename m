From: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] SPI: MIPS: lantiq: adds spi-xway
Date: Wed, 22 Aug 2012 21:04:56 +0200
Message-ID: <50352D58.6040201@openwrt.org>
References: <1345103821-12543-1-git-send-email-blogic@openwrt.org>
	<20120822185944.GD7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Daniel Schwierzeck <daniel.schwierzeck-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120822185944.GD7995-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 22/08/12 20:59, Mark Brown wrote:
>> +       if (of_machine_is_compatible("lantiq,ase"))
>> > +               master->num_chipselect = 3;
>> > +       else
>> > +               master->num_chipselect = 6;
> This is very suspicious - why is this being done based on the machine
> rather than based on the IP?  Surely there can be machines with this SoC
> on which aren't compatible with whatever (reference?) board this is
> matching on.  I'd expect that the driver would have multiple compatible
> strings which it uses to distinguish the capabilities of the IP.
>
> Though actually the driver never reads this value so perhaps the code
> can just be deleted and we rely on the fact that if the /CS isn't
> physically present nobody's going to hook it up on a board so just
> always set it to 6?
>
Thanks for the review i will rework the driver, add a binding doc and
resend ...

is there a equivalent of of_machine_is_compatible for IP ?

John

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
