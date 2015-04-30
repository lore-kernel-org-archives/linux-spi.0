From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH 3/3] spi: Re-do the returning value of qspi_transfer_out_in
Date: Thu, 30 Apr 2015 09:28:05 +0900
Message-ID: <55417715.7020005@jinso.co.jp>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>	<1430200551-20708-4-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdVYnEiGaHzXFgH_pWmFRwWH91RQfm7RyS-XG9FvUTb_Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVYnEiGaHzXFgH_pWmFRwWH91RQfm7RyS-XG9FvUTb_Mg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 2015=E5=B9=B404=E6=9C=8828=E6=97=A5 20:07, Geert Uytterhoeven wrote:
> On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> =
wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> To reduce complex of code, drop "ret" then qspi_transfer_out_in func=
tion
>> should be returned the value of "qspi_trigger_transfer_out_in" direc=
tly.
>>
>> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Thanks,


