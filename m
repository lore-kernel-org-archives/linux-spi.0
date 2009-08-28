From: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Subject: RE: [patch 2.6.31-rc7] spi: davinci spi driver
Date: Fri, 28 Aug 2009 05:29:36 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D91E07BD3@dlee01.ent.ti.com>
References: <200908271858.48850.david-b@pacbell.net>
	<4A979CEE.1040500@ru.mvista.com>
	<200908280221.24889.david-b@pacbell.net>,
	<4A97ACF4.8030203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        DaVinci <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>,
        David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A97ACF4.8030203-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Sergei, Dave,

When i started this SPI process many moons ago, i am absolutely sure that i=
 sent out e-mails on our internal TI MV mailing list asking for the appropr=
iate signoffs. I can dig out the e-mails but i don't see what can be achiev=
ed on doing that. I did not get any responses then.

Obviously that time the driver was not ready for submission and now seems a=
n auspicious time.

I'll take care of all pending issues, i.e signoffs, copyright(which as poin=
ted out was not present in the original driver) and send the patch.

Thanks,
Sandeep


________________________________________
From: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org [davinci-linux=
-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf Of Sergei Shtylyov [ss=
htylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org]
Sent: Friday, August 28, 2009 6:09 AM
To: David Brownell
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Andrew Morton; DaVinci
Subject: Re: [patch 2.6.31-rc7] spi: davinci spi driver

Hello.

David Brownell wrote:

>>> From: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
>>>
>>> The patch adds a SPI driver for DaVinci series SOC's.
>>>
>>> [dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: fixes and cleanup]
>>>
>>> Signed-off-by: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>>
>>>
>>   This patch lacks MV people's signoffs (and MV copyright on the driver)=
.
>>
>
> -ENOPATCH
>
> I don't recall seeing any version with MV attributions, FWIW.

   Because there was none. :-)
   I have just mailed Sandeep about this yesterday.

WBR, Sergei



_______________________________________________
Davinci-linux-open-source mailing list
Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
