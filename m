From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Wed, 15 Feb 2017 09:26:25 +0900
Message-ID: <58A3A031.3080307@jinso.co.jp>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp> <CAMuHMdUyA9+KLaD9rY9gYjxjZcQ1bWKoDhP25mEAdZTr7E0uwA@mail.gmail.com> <ed0b8422-8ab1-7d8d-318f-343e6e2de17d@jinso.co.jp> <CAMuHMdVDgjBF+c-z4=LH+PD00oiNFqhShQuZ0ELS0S4YpQ=npg@mail.gmail.com> <58A15724.1060901@jinso.co.jp> <CAMuHMdU4v=KszacVQ5GX-JVoov0TdfH=+fkpyC505eUWTGpEqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: DongCV <cv-dong@jinso.co.jp>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?RHVuZ++8muS6ug==?= =?UTF-8?B?44K9?=
        <nv-dung@jinso.co.jp>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU4v=KszacVQ5GX-JVoov0TdfH=+fkpyC505eUWTGpEqg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Sorry for the delay.

Thanks for your reply.


> On Mon, Feb 13, 2017 at 7:50 AM, Hiep Cao Minh <cm-hiep@jinso.co.jp> wrote:
>> Sorry to bother you!
> No, thank you for finally make me see my wrong reasoning!
>
>>> qspi_transfer_in() does:
>>>
>>>           while (n > 0) {
>>>                   len = qspi_set_receive_trigger(rspi, n);
>>>                   // len will be <= n
>> I agree. This is len = min value of n and 32.
>>>                   if (len == QSPI_BUFFER_SIZE) {
>>>                           // receive blocks of len bytes
>> Yes, This is len == 32 bytes
>>>                           ...
>>>                   } else {
>>>                           // receive n (not len) bytes
>> This is always n == len ( This case, len or n is always < 32)
>> Because this is the last n bytes should be received.
> Right.
> Doh, I must have missed that if "len < n", the first branch is always taken.
>
>>>                           ret = rspi_pio_transfer(rspi, NULL, rx, n);
> It would have been clearer to use "len" here instead of "n".
I agree, Dong will update your suggestion at the patch.

Thank you.
Hiep.
