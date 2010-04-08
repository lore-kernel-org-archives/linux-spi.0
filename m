From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Thu, 8 Apr 2010 11:43:10 +0200
Message-ID: <h2xcabda6421004080243ifd2a47e4u8033a187b415d031@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	 <1269340170-6558-1-git-send-email-chripell@fsfe.org>
	 <20100329104838.49c18075@feng-i7>
	 <v2ocabda6421004080231r7b7a734ao9fce206a82bf944b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"greg@kroah.com" <greg@kroah.com>,
	"david-b@pacbell.net" <david-b@pacbell.net>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Feng Tang <feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <v2ocabda6421004080231r7b7a734ao9fce206a82bf944b@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 8, 2010 at 11:31 AM, christian pellegrin <chripell@fsfe.org=
> wrote:
> On Mon, Mar 29, 2010 at 4:48 AM, Feng Tang <feng.tang@intel.com> wrot=
e:
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 tx |=3D MAX3100_WD | MAX3100_RTS;
>>
>> Does this imply to have to work with HW flow control? on my platform
>> I have to remove the RTS bit to make it work.
>>
>
> Finally I had time to check this. If you compare the 8250 (or similar=
)
> data-sheet with the MAX31x0 one you see that the handling of the
> RTX/CTS bits is exactly the same (8250 about RTS bit for example:
> "When any of these bits are cleared, the associated output is forced
> high." and MAX3110: "Request-to-Send Bit. Controls the state of the
> RTS output. This bit is reset on power-up (RTS
> bit =3D 0 sets the RTS pin =3D logic high)."). If you look at the 825=
0.c
> driver (grep for UART_MCR_RTS) you notice that the bit is set on
> device open (together with DTR of course). So I think the driver is
> doing the right thing here.
>

anyway I'll set it to on only in case the flow control is enabled. So
even if, for some reason, you have to keep it to off on your platform,
it won't make troubles.


--=20
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
